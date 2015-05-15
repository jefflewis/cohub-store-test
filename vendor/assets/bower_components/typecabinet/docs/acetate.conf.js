function config(acetate) {
  acetate.global('config', {
    environment: 'dev',
  });

  acetate.layout('**/*', 'layouts/_layout:content');

  acetate.src = 'source';
  acetate.dest = 'build';

  acetate.notFound = '404.html';
}

module.exports = config;