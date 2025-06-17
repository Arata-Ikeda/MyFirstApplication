// babel.config.js

module.exports = {
  presets: [
    // ↓ 複雑なオプションを外して、シンプルにする
    '@babel/preset-env',

    // ↓ こちらはそのまま
    ['@babel/preset-react', { runtime: 'automatic' }]
  ]
};