const config = {
  entry: {
    index: './src/index.js',
    game: './src/game.js',
  },
  output: {
    filename: '[name].bundle.js',
  },
  mode: 'development',
  watchOptions: {
    ignored: /node_modules/
  }
};
export default config
