#!/bin/sh
export $(cat .env | xargs)

cd $TMP

for dir in * ; do
  cd $dir
  cat pid.txt
  cat pid.txt | xargs kill
  cd ..
done

