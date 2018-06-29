# beer

> A listing of local places with beer

https://brewingcode.github.io/beer/

## Build Setup

``` bash
# initial setup
git clone https://github.com/brewingcode/beer
git clone https://github.com/brewingcode/vue-table-component
cd vue-table-component
yarn && yarn build && yarn link # tests fail, it's ok
cd ../beer
yarn && yarn link vue-table-component

# write token to file in order to tell beerproxy server we are ok to CORS
echo $TOKEN > auth.txt

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
