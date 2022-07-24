const env = process.env.EMBER_ENV || 'development';

const plugins = [require('postcss-nested'), require('autoprefixer')];

if (env === 'production') {
  plugins.push(
    require('cssnano')({
      preset: 'default',
    })
  );
}

module.exports = {
  plugins,
};
