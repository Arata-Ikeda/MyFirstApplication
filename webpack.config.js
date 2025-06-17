// webpack.config.js

const path = require("path")

module.exports = {
  mode: "production",
  entry: {
    application: "./app/javascript/application.jsx" // .js から .jsx に変更
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[name].js.map",
    path: path.resolve(__dirname, "app/assets/builds"),
  },
  // --- ここから下を追加 ---
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: ['babel-loader']
      }
    ]
  },
  resolve: {
    extensions: ['.js', '.jsx']
  }
  // --- ここまで追加 ---
}