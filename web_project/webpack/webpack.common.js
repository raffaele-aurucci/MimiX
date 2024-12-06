const path = require('path')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const WorkboxPlugin = require('workbox-webpack-plugin');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const webpack = require('webpack')

module.exports = {
  performance: { hints: false },
   entry: {
    index: "./src/index.ts",
     style: "./src/style.ts",
   
    },
  output: {
    path: path.resolve(__dirname, '../public'),
    filename: '[name].bundle.js',
    chunkFilename: '[name].chunk.js'
  },
 
  resolve: {
    extensions: ['.ts', '.tsx', '.js']
  },
  
  module: {
    rules: [
      
      {
        test: /\.tsx?$|\.jsx?$/,
        include: path.join(__dirname, '../src'),
        loader: 'ts-loader'
      },
      
      {
                test: /\.scss$/,
                exclude: /(node_modules)/,
                use: [
                    MiniCssExtractPlugin.loader,
                    {
                        loader: "css-loader",
                        options: {
                            sourceMap: true,
                            url: false,
                        },
                    },
                    {
                        loader: "postcss-loader",
                        options: {
                           
                        },
                    },
                    {
                        loader: "sass-loader",
                        options: {
                          warnRuleAsWarning: false,
                            sourceMap: true,
                            sassOptions: {
                                outputStyle: "expanded",
                            },
                        },
                    },
                ],
            },
    
    
    ]

    
  },
  optimization: {
    splitChunks: {
      cacheGroups: {
        commons: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          chunks: 'all',
          filename: '[name].bundle.js'
        }
      }
    }
  },
  plugins: [

     new MiniCssExtractPlugin({
            filename: "[name].[contenthash].css",
            chunkFilename: "[id].css",
     }),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.ProvidePlugin({
            $: "jquery",
            jQuery: "jquery",
    }),
    
    new webpack.ProgressPlugin(),
     
  new HtmlWebpackPlugin({
     
      filename: "index.html",
      template: 'src/index.html',
      chunks: ['vendors', 'index','style'],
  }),



  
  
    new CopyWebpackPlugin({
      patterns: [
        { from: 'src/assets', to: 'assets' },
        // { from: 'src/favicon.ico', to: '' }
      ]
    }),

  ]
}