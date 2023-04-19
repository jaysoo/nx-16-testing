#!/bin/sh

cd tmp

for dir in * ; do
  cd $dir

  next_version=$(cat package.json | jq ".dependencies.next ")

  if [ "$next_version" != "null" ]; then
    echo "Adding Storybook to Next.js workspace: $dir"

    # Determine style to use
    style="unknown"
    if [[ "$dir" =~ css$ ]]; then
      style="css"
    fi
    if [[ "$dir" =~ less$ ]]; then
      style="less"
    fi
    if [[ "$dir" =~ scss$ ]]; then
      style="scss"
    fi
    if [[ "$dir" =~ emotion$ ]]; then
      style="@emotion/styled"
    fi
    if [[ "$dir" =~ styled-components$ ]]; then
      style="styled-components"
    fi
    if [[ "$dir" =~ styled-jsx$ ]]; then
      style="styled-jsx"
    fi

    npx nx g @nrwl/react:component Message --project=demo --style=$style --export=false
    npx nx g @nrwl/react:storybook-configuration demo --generateStories --no-interactive
  else 
    echo "Adding Storybook to React workspace: $dir"
    npx nx g @nrwl/react:component Message --export=false
    npx nx g @nrwl/react:storybook-configuration $dir --generateStories --no-interactive
  fi

  cd ..
done


