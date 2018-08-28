const { environment } = require('@rails/webpacker')
const webpack = require('webpack');
const customConfig = require('./custom');
const customPlugins = require('./customPlugins');
environment.config.merge(customConfig);
environment.config.merge(customPlugins);
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: 'popper.js',
  })
);

module.exports = environment
