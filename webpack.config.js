const webpack = require('webpack');
const path = require('path');
/*
 * We've enabled UglifyJSPlugin for you! This minifies your app
 * in order to load faster and run less javascript.
 *
 * https://github.com/webpack-contrib/uglifyjs-webpack-plugin
 *
 */
const UglifyJSPlugin = require('uglifyjs-webpack-plugin');
module.exports = {
  entry: './src/frontend/index.js',
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'public/js')
  },
  module: {
    rules: []
  },
  plugins: [new UglifyJSPlugin()]
};