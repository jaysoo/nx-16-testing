#!/bin/sh
export $(cat .env | xargs)

cd $TMP

for dir in * ; do
  cd $dir

  next_version=$(cat package.json | jq ".dependencies.next ")

  if [ "$next_version" != "null" ]; then
    echo "Adding Storybook to Next.js workspace: $dir"

    # Determine style to use
    style="css"
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

    npx nx g @nrwl/next:lib ui --style=$style --no-interactive --unitTestRunner=jest
    npx nx g @nrwl/react:component Message --project=ui --style=$style --export=true
    npx nx g @nrwl/react:storybook-configuration ui --generateStories --no-interactive
  else 
    echo "Adding Storybook to React workspace: $dir"

    # Determine style to use
    test_runner="jest"
    if [[ "$dir" =~ vite$ ]]; then
      test_runner="vitest"
    fi

    npx nx g @nrwl/react:lib ui --style=$style --no-interactive --unitTestRunner=$test_runner
    npx nx g @nrwl/react:component Message --export=true --project=ui
    npx nx g @nrwl/react:storybook-configuration ui --generateStories --no-interactive
  fi

  cd ..
done


