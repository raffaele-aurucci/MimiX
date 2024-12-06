const HtmlWebpackPlugin = require('html-webpack-plugin')
const { merge } = require('webpack-merge')
const common = require('./webpack.common')

const dev = {
    entry: {
   
   
    },
  mode: 'development',
   optimization: {
        runtimeChunk: 'single'
    },
  target: 'web',
  devtool: 'inline-source-map',
  devServer: {
    open: true,
     port: 9000, hot: true,
  },
  plugins: [
   
  ]
}


module.exports = merge(common, dev)