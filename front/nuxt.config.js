const environment = process.env.NODE_ENV || 'development';
const envSet = require(`./env.${environment}.js`)

export default {

  env: envSet,

  // Global page headers (https://go.nuxtjs.dev/config-head)
  head: {
    title: 'gadget-app',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },

  // Global CSS (https://go.nuxtjs.dev/config-css)
  css: [
  ],

  // Plugins to run before rendering page (https://go.nuxtjs.dev/config-plugins)
  plugins: [
    '~/plugins/vee-validate',
    { src: '~/plugins/vue-tags-input.js', ssr: false},
    { src: '~/plugins/vue-infinite-loading.js', ssr: false}
  ],

  // Auto import components (https://go.nuxtjs.dev/config-components)
  components: true,

  // Modules for dev and build (recommended) (https://go.nuxtjs.dev/config-modules)
  buildModules: [
    '@nuxtjs/vuetify',
    '@nuxtjs/moment'
  ],

  // Modules (https://go.nuxtjs.dev/config-modules)
  modules: [
    '@nuxtjs/axios',
  ],
  axios: {

  },

  // Build Configuration (https://go.nuxtjs.dev/config-build)
  build: {
    transpile: [
      "vee-validate/dist/rules"
    ],
  },

  vuetify: {
    customVariables: ['~/assets/variables.scss'],
    treeShake: true,
  }
}
