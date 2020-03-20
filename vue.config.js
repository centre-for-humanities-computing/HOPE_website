module.exports = {
  "transpileDependencies": [
    "vuetify"
  ],
  "configureWebpack": {
    "module": {
      "rules": [
        {
          "test": /content\/[\w\W]+\.md$/,
          "exclude": /dist|node_components|src/,
          "use": [
            "vue-loader",
            {
              "loader": "markdown-to-vue-loader",
              "options": {
                "exportSource": true
              }
            }
          ]
        }
      ]
    }
  },
  "runtimeCompiler": true
}
