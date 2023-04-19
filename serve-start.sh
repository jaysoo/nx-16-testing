#!/bin/sh
export $(cat .env | xargs)

cd $TMP

port=3000

for dir in * ; do
  cd $dir

  next_version=$(cat package.json | jq ".dependencies.next ")

  if [ "$next_version" != "null" ]; then
    npx nx serve demo --port=$port > /dev/null &
    pid=$!
    echo $pid | cat > pid.txt
  else
    npx nx serve --port=$port > /dev/null &
    pid=$!
    echo $pid | cat > pid.txt
  fi

  echo "$dir started at http://localhost:$port"
  port=$((port+1))  

  cd ..
done

