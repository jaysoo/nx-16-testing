#!/bin/sh
export $(cat .env | xargs)

mkdir -p $TMP
cd $TMP

ver="${1:-latest}"

echo "Create workspaces with Nx $ver"

npx -y -q create-nx-workspace@$ver node-cli --preset=node-standalone --framework=none --no-nx-cloud
npx -y -q create-nx-workspace@$ver node-fastify --preset=node-standalone --framework=fastify --no-nx-cloud --docker
npx -y -q create-nx-workspace@$ver node-nest --preset=node-standalone --framework=nest --no-nx-cloud --docker
npx -y -q create-nx-workspace@$ver node-express --preset=node-standalone --framework=express --no-nx-cloud --docker
npx -y -q create-nx-workspace@$ver node-koa --preset=node-standalone --framework=koa --no-nx-cloud --docker
npx -y -q create-nx-workspace@$ver react-vite --preset=react-standalone --style=css --no-nx-cloud --bundler=vite
npx -y -q create-nx-workspace@$ver react-webpack --preset=react-standalone --style=css --no-nx-cloud --bundler=webpack
npx -y -q create-nx-workspace@$ver next-css --preset=next --appName=demo --style=css --no-nx-cloud --bundler=webpack
npx -y -q create-nx-workspace@$ver next-scss --preset=next --appName=demo --style=scss --no-nx-cloud --bundler=webpack
npx -y -q create-nx-workspace@$ver next-less --preset=next --appName=demo --style=less --no-nx-cloud --bundler=webpack
npx -y -q create-nx-workspace@$ver next-styled-components --preset=next --appName=demo --style=styled-components --no-nx-cloud --bundler=webpack
npx -y -q create-nx-workspace@$ver next-styled-jsx --preset=next --appName=demo --style=styled-jsx --no-nx-cloud --bundler=webpack
npx -y -q create-nx-workspace@$ver next-emotion --preset=next --appName=demo --style=@emotion/styled --no-nx-cloud --bundler=webpack
