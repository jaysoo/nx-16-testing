#!/bin/sh
export $(cat .env | xargs)

cd $TMP

for dir in * ; do
  cd $dir
  npx nx run-many -t=lint || { echo "lint failed for $dir"; exit 1; }
  cd ..
done

