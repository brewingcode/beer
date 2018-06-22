const routerBase = (function() {
  const base = {
    router: {
      middleware: 'default-index',
    },
  };

  if (process.env.ROUTER_BASE) {
    base.router.base = process.env.ROUTER_BASE;
  }

  return base;
})();

module.exports = {
  /*
  ** Headers of the page
  */
  head: {
    title: 'Beer',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'A listing of local places with beer' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
    ],
  },
  /*
  ** Customize the progress bar color
  */
  loading: { color: '#3B8070' },
  /*
  ** Build configuration
  */
  build: {
    /*
    ** Run ESLint on save
    */
    extend (config, { isDev, isClient }) {
      if (isDev && isClient) {
        // config.module.rules.push({
        //   enforce: 'pre',
        //   test: /\.(js|vue)$/,
        //   loader: 'eslint-loader',
        //   exclude: /(node_modules)/
        // })
      }

      config.module.rules.push({
        // enforce: 'pre', // Do we need this? Literally no one can know!
        test: /\.coffee$/,
        loader: 'coffee-loader'
      });

      // set this to get `yarnk link` working
      config.resolve.symlinks = false;
    }
  },
  ...routerBase,
  plugins: [
    { src: '~/plugins/components.coffee', ssr: true }
  ],
  modules: [
    'bootstrap-vue/nuxt',
  ],
  generate: {
    routes: [
      '/yardhouse',
      '/pinebox',
      '/brouwers',
      '/chucks-greenwood',
      '/chucks-cd',
    ],
  },
}
