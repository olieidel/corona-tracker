const { environment } = require('@rails/webpacker')

// Don't transpile node-modules folder through babel-loader.
// Problem: https://github.com/mapbox/mapbox-gl-js/issues/3422
// Fix: https://github.com/rails/webpacker/blob/cb4e4c8c137780ffa549c71b84e66b3ec8c98575/docs/v4-upgrade.md
environment.loaders.delete('nodeModules');

module.exports = environment
