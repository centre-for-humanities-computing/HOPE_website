const path = require("path");

module.exports = {
  "configureWebpack": {
    "module": {
      "rules": [
        {
          "test": /\/content\/[^/]+\.md$/,
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
  "runtimeCompiler": true,
  outputDir: path.resolve(__dirname, "./docs")
}
