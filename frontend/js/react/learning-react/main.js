var topic = "JavaScript";

if (topic) {
  let topic = "React";
  console.log("block", topic); // React
}

console.log("global", topic); // JavaScript


// Reactは全部これ：
// ❌ 曖昧さを許す設計
// hoisting
// var
// グローバル副作用
//
// ⭕ 明確さを強制する設計
// const / let
// 関数式
// 純粋関数
//
// hoisting自体が悪いわけではない
// 問題は「コードの見た目と実行順がズレること」
//

// ReactにおいてUIは関数である
// UI = f(props)
//
// JSXで書いたタグの属性は全てがpropsになる
// Vue.jsのpropsとの違いに注意する

// 6to5というツールがBabelに改名された
// JSXを書く
// ↓
// Babel（コンパイル）
// ↓
// React.createElement
// ↓
// ReactElement（設計図）
// ↓
// ReactDOM.render
// ↓
// 実DOM更新

// 開発時：
//   JSXを書く
// ↓
// ビルド時：
//   Babelで変換
// ↓
// 本番：
//   変換済みJSだけ配信
