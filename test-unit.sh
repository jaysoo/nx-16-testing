#!/bin/sh
export $(cat .env | xargs)

cd $TMP

for dir in * ; do
  cd $dir
  npx nx run-many -t=test || { echo "test failed for $dir"; exit 1; }
  cd ..
done

