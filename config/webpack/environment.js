const { environment } = require('@rails/webpacker')
const customConfig = require('./custom');

const webpack = require('webpack');
environment.config.merge(customConfig);
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: 'popper.js'
  })
);

module.exports = environment
