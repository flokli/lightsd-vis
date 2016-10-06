var webpack = require('webpack');
var getConfig = require('hjs-webpack');

var config = getConfig({
	in: 'src/app.coffee',
	out: 'public',
	clearBeforeBuild: true
});

config.plugins.push(
	new webpack.ProvidePlugin({
		jQuery: 'jquery',
		$: 'jquery',
		'window.jQuery': 'jquery'
	})
);

module.exports = config;
