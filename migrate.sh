#!/bin/sh
export $(cat .env | xargs)

cd $TMP

ver="${1:-next}"

for dir in * ; do
  cd $dir

  echo "migrating $dir to $ver"

  git add .
  git commit -m 'before migration' --allow-empty > /dev/null

  CI=true npx nx migrate $ver --no-interactive || { echo "migrate failed: $dir"; exit 1; }
  npm install || { echo "install failed: $dir"; exit 1; }
  npx nx migrate --run-migrations || { echo "run migration failed: $dir"; exit 1; }
  git add .
  git commit -m 'after migration' > /dev/null

  cd ..
done

