#!/bin/sh
export $(cat .env | xargs)

mkdir -p $TMP
cd $TMP

npx -y -q create-nx-workspace@15.9.2 react-vite --preset=react-standalone --style=css --no-nx-cloud --bundler=vite
npx -y -q create-nx-workspace@15.9.2 react-webpack --preset=react-standalone --style=css --no-nx-cloud --bundler=webpack
npx -y -q create-nx-workspace@15.9.2 next-css --preset=next --appName=demo --style=css --no-nx-cloud --bundler=webpack
npx -y -q create-nx-workspace@15.9.2 next-scss --preset=next --appName=demo --style=scss --no-nx-cloud --bundler=webpack
npx -y -q create-nx-workspace@15.9.2 next-less --preset=next --appName=demo --style=less --no-nx-cloud --bundler=webpack
npx -y -q create-nx-workspace@15.9.2 next-styled-components --preset=next --appName=demo --style=styled-components --no-nx-cloud --bundler=webpack
npx -y -q create-nx-workspace@15.9.2 next-emotion --preset=next --appName=demo --style=@emotion/styled --no-nx-cloud --bundler=webpack
npx -y -q create-nx-workspace@15.9.2 next-styled-jsx --preset=next --appName=demo --style=styled-jsx --no-nx-cloud --bundler=webpack
