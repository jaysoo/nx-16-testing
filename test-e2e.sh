#!/bin/sh
export $(cat .env | xargs)

cd $TMP

PORT=3000
export PORT

for dir in * ; do
  cd $dir

  nx_node_version=$(cat package.json | jq '.devDependencies|.["@nx/node"]')
  nrwl_node_version=$(cat package.json | jq '.devDependencies|.["@nrwl/node"]')
  if [ "$nx_node_version" != "null" ] || [ "$nrwl_node_version" != "null" ]; then
    npx nx serve --verbose&
    sleep 3
    npx nx run-many -t=e2e --parallel=1
    ret=$?
    lsof -i:$PORT | grep node | awk '{print $2}' | xargs kill
    sleep 2
    if [ $ret -ne 0 ]; then
      echo "e2e failed for $dir"
      exit 1
    fi
    PORT=$((PORT+1))  
    export PORT
  else
    npx nx run-many -t=e2e --parallel=1 || { echo "e2e failed for $dir"; exit 1; }
  fi

  cd ..
done

