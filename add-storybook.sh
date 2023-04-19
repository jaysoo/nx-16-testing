#!/bin/sh

cd tmp
for dir in */ ; do
  cd $dir

  next_version=$(cat package.json | jq ".dependencies.next ")

  if [ "$next_version" != "null" ]; then
    echo "Adding Storybook to Next.js workspace: $dir"
    npx nx g @nrwl/react:component Message --project=demo
    npx nx g @nrwl/react:storybook-configuration --generateStories --no-interactive
  else 
    echo "Adding Storybook to React workspace: $dir"
    npx nx g @nrwl/react:component Message
    npx nx g @nrwl/react:storybook-configuration --generateStories --no-interactive
  fi

  cd ..
done


