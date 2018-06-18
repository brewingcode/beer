# yardhouse

> A better listing of Yard House beers

https://brewingcode.github.io/yardhouse/

## Build Setup

``` bash
# initial setup
git clone https://github.com/brewingcode/vue-table-component
cd vue-table-component
yarn && yarn build && yarn link # tests fail, it's ok
cd ..
git clone https://github.com/brewingcode/yardhouse
cd yardhouse
yarn && yarn link vue-table-component && yarn dev

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
