#!/bin/sh
export $(cat .env | xargs)

cd $TMP

for dir in * ; do
  cd $dir

  fastify_version=$(cat package.json | jq ".dependencies.fastify ")
  if [ "$fastify_version" != "null" ]; then
    npx nx serve&
    pid=$!
    npx nx run-many -t=e2e --parallel=1
    ret=$?
    kill $pid
    if [ $ret -ne 0 ]; then
      echo "e2e failed for $dir"
      exit 1
    fi
else
    npx nx run-many -t=e2e --parallel=1 || { echo "e2e failed for $dir"; exit 1; }
  fi
  cd ..
done

