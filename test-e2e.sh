#!/bin/sh
export $(cat .env | xargs)

cd $TMP

for dir in * ; do
  cd $dir
  npx nx run-many -t=e2e --parallel=1 || { echo "e2e failed for $dir"; exit 1; }
  cd ..
done

