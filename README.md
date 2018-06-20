# yardhouse

> A better listing of Yard House beers

https://brewingcode.github.io/yardhouse/

## Build Setup

``` bash
# initial setup
git clone https://github.com/brewingcode/vue-table-component
git clone https://github.com/buhrmi/nuxt-coffee

cd vue-table-component
yarn && yarn build && yarn link # tests fail, it's ok
cd ../nuxt-coffee
yarn && yarn link

cd ../yardhouse
yarn && yarn link vue-table-component && yarn link nuxt-coffee

# serve with hot reload at localhost:3000
yarn dev

# build for production and launch server
yarn build
yarn start

# generate static project
yarn generate

# generate static project at non-root url
ROUTER_BASE=/some/other/url/ yarn generate
```

For detailed explanation on how things work, checkout the [Nuxt.js docs](https://github.com/nuxt/nuxt.js).
