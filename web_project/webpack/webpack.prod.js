const path = require('path')
const { merge } = require('webpack-merge')
const common = require('./webpack.common')
const WebpackObfuscator = require('webpack-obfuscator')
const { InjectManifest } = require('workbox-webpack-plugin')
const prod = {
  mode: 'production',
  output: {
    filename: '[name].[contenthash].bundle.js',
    chunkFilename: '[name].[contenthash].chunk.js'
  },
  optimization: {
    splitChunks: {
      cacheGroups: {
        commons: {
          filename: '[name].[contenthash].bundle.js'
        }
      }
    }
  },
  plugins: [
   



    
    new WebpackObfuscator(
       {
         rotateStringArray: true,
         stringArray: true,
         stringArrayThreshold: 0.75
       },
       ['vendors.*.js']
     )
     
  ]
}

module.exports = merge(common, prod)