const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  // build 경로 설정
  // outputDir: "../todomypet_backend/src/main/resources/static",
  devServer: {
    // 프록시 설정
    proxy: {
      '/api': {
        target: this.cloudtypeUrl,
        changeOrigin: true
      },
      '/memberLogin': {
        target: this.cloudtypeUrl,
        changeOrigin: true
      },
      '/solveProblem': {
        target: this.cloudtypeUrl,
        changeOrigin: true
      },
      '/mode': {
        target: this.cloudtypeUrl,
        changeOrigin: true
      },
      '/incorrectNote': {
        target: this.cloudtypeUrl,
        changeOrigin: true
      }
    }
  }
})
