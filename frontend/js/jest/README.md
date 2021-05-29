## 確認
`$ node -v`  
v14.17.0

`$ yarn -v`  
1.22.10

## vue CLIのインストール

### npmでインストールする場合  
`$ npm install -g @vue/cli`

### yarnでインストールする場合  
`$ yarn global add @vue/cli`

@vue/cliが入ったことの確認  
`$ vue --version`  
@vue/cli 4.5.13


## プロジェクトの作成

$ vue create hello-world-v2  
$ cd hello-world-v2  
$ yarn serve  

でサーバーが起動する。
http://localhost:8080 にアクセスしてデフォルトの画面が出たらok。

## 必要なものをインストール

$ npm install —save-dev @vue/test-utils vue-jest jest babel-jest @babel/core @babel/preset-env babel-core@bridge  
$ yarn add --dev @vue/test-utils vue-jest jest babel-jest @babel/core @babel/preset-env babel-core@bridge

### 簡単にインストールするライブラリの概要
Vue3からはインストールするものが変わると思います。
今回はVueのv2で構築していきます。  
TypeScriptを使う場合は、また別途インストールしたり設定が必要です。  

- @vue/test-utils
  - Vue.js公式のテストライブラリ
  - コンポーネントのマウントや操作でいる

- jest
  - Jestのテストフレームワークの本体

- vue-jest
  - jestでVueを使うのにいる

- babel-jest @babel/core @babel/preset-env babel-core@bridge
  - jestとbabelなどの互換性を保つためにいる

## 必要な設定

package.jsonのscripts以下に`"test": "jest"`を追加
```json
"scripts": {
  ...
  ...
  "test": "jest"
}
```

package.jsonに`"jest"`の設定を追加。

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
- moduleFileExtensions
  - モジュールで使うファイルの拡張子を指定

- transform
  - vueやjsファイルをそれぞれのライブラリで変換するように指定する

- testEnvironment
  - テスト環境ではjsdomを使うように指定する。指定しないとmountとかのメソッドでエラーでると思う。

babel.config.json（またはbabelrc.jsonでもok）
```json
env: {
  test: {
    presets: ["@babel/preset-env"]
  }
}
```

## まずコンポーネントのマウント方法を学ぶ
vueでjest使う場合はまずコンポーネントのマウントの仕方と、オプションについて学ぶと良さそうです。

簡単に関数とかのテストなら設定とかなしで簡単にかけますが、VueやReactのテストをする場合は、コンポーネントのテストがメインになると思われます。  

そのため、コンポーネントをマウントして各属性やプロパティへアクセスする方法などを知っておくと、あとあとテストが書きやすいです。  

公式サイトの↓に色々書かれているので、ドキュメントを参照する機会は多そうです。  
https://vue-test-utils.vuejs.org/api/wrapper/#methods  

### mountとshallowMount
```js
import { mount } from "@vue/test-utils";
```

と

```js
import { shallowMount } from "@vue/test-utils";
```

で動作が違います。  

mountは親子まとめて関連するコンポーネントもレンダーします。  

一方で、shallowMountはそのコンポーネントだけレンダーし、子コンポーネントはスタブとしてレンダーします。  

以上の動作をすることから、結合テストではmount、単体テストではshallowMountを使うことが多そうです。  

## toMatchSnapshot()
expect(cmp.element).toMatchSnapshot();
といった具合にtoMatchSnapshot()メソッドを使うとスナップショットのテストができます。

出力されるデータ構造をチェックできるので、HTML構造や状態などが意図せず変更された場合に気づけるようになります。

スナップショットが確実に変更される場合は  
$ yarn test -u
$ npm test -u

と、`-u`のオプションをつけるとスナップショットを上書きできます。  

意図的に構造を変更した場合は上書きしないとテストが落ちるので、上書きしてテストを実行します。

## --watchオプション
`--watch`オプションをつかうと、テストが変更されるたび再実行することができます。  

ただし、頻繁にテストが実行されることになるので、場合に応じて設定するで良いと思います。

## Lintの導入
簡単なのはエディタの拡張機能を使うことです。
ESLint、StyleLintなどがほぼ使われるので、チーム内で合わせておけば良いと思います。

eslintはVue CLIを使うならデフォルトでインストールされるはずなので、特に設定は不要です。

stylelintをインストールする場合は  
`$ npm install --save-dev stylelint stylelint-config-standard`  
`$ yarn add --dev stylelint stylelint-config-standard`  
でインストールできます。

stylelint-config-standardは標準的なruleを追加してくれるプラグインです。

eslintやstylelintを使う場合は.eslintrc.jsonとか.stylelintrc.jsonというファイルをプロジェクトのルートに作成します。  
プラグインによっては、違う設定方法が明示されていることもあります。  


stylelint-config-standardを使う場合は.stylelintrc.jsonというファイルを作成して
```json
{
  "extends": "stylelint-config-standard"
}
```
と拡張機能をつかう設定を書きます。

pakage.jsonにstylelintを実行するコマンドを追加します。
`"s-lint": "stylelint --fix ./src/**/*.css"`

これで準備できたので、適当にCSSファイルを作成して試してみると良いでしょう。  
