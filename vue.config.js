const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
      target: 'http://127.0.0.1:8000',
      changeOrigin: true,
      headers: { "Access-Control-Allow-Origin": "*" },
  },
})
