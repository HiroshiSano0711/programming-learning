$ node -v
v14.17.0

$ yarn -v
1.22.10

vue CLIのインストール
$ npm install -g @vue/cli
$ yarn global add @vue/cli

$ vue --version
@vue/cli 4.5.13

プロジェクトの作成
$ vue create hello-world-v2
$ cd jest-test
$ yarn serve

必要なものをインストール
$ npm install —save-dev @vue/test-utils vue-jest jest babel-jest @babel/core @babel/preset-env babel-core@bridge

$ yarn add --dev @vue/test-utils vue-jest jest babel-jest @babel/core @babel/preset-env babel-core@bridge

必要な設定

package.json

```json
"scripts": {
  "test": "jest"
}
```

package.json

```json
"jest": {
  "moduleFileExtensions": [
    "js",
    "json",
    "vue"
  ],
  "transform": {
    ".*\\.(vue)$": "vue-jest",
    ".*\\.(js)$": "babel-jest"
  },
  "testEnvironment": "jsdom"
}
```

babel.config.json
```json
env: {
  test: {
    presets: ["@babel/preset-env"]
  }
}
```
