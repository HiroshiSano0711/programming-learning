/*
この学習はJavaScript Ninjaの極意（ECMAScript2015）を元にしています。
ECMAScript2016以降の新しい構文を学ぶことが目的ではなくJavaScriptのオブジェクト、関数、クロージャについて理解することが目的。
基本的な概念を押さえれば、あとは差分で学習できるため。

*/
// 単純なアサート
// function assert(value, desc){
//   var li = document.createElement('li');
//   li.className = value ? 'pass' : 'fail';
//   li.appendChild(document.createTextNode(desc));
//   document.getElementById('results').appendChild(li);
// }

// window.onload = function(){
//   assert(true, 'テストスイートを実行中。');
//   assert(false, '失敗');
// }

// テストグループでテストスイートを実行する
// (function() {
//   var results;
//   this.assert = function assert(value, desc){
//     var li = document.createElement('li');
//     li.className = value ? 'pass' : 'fail';
//     li.appendChild(document.createTextNode(desc));
//     results.appendChild(li);
//     if(!value) {
//       li.parentNode.parentNode.className = 'fail';
//     }
//     return li;
//   };
//   this.test = function test(name, fn) {
//     results = document.getElementById('results');
//     results = assert(true, name).appendChild(document.createElement('ul'));
//     fn();
//   };
// })();

// window.onload = function(){
//   test('テストA', function() {
//     assert(true, '1のテストok');
//     assert(true, '2のテストok');
//     assert(true, '3のテストok');
//   });
//   test('テストB', function() {
//     assert(true, '1のテストok');
//     assert(false, '2のテストng');
//     assert(true, '3のテストok');
//   });
//   test('テストC', function() {
//     assert(null, 'ng');
//     assert(5, 'ok');
//   });
// }

// シンプルな非同期テストスイート
// (function() {
//   var queue = [], paused = false, results;

//   this.test = function(name, fn) {
//     queue.push(function() {
//       results = document.getElementById("results");
//       results = assert(true, name).appendChild(document.createElement("ul"));
//       fn();
//     });
//     runTest();
//   }

//   this.pause = function(){
//     paused = true;
//   }

//   this.resume = function(){
//     paused = false;
//     setTimeout(runTest, 1);
//   }

//   function runTest(){
//     if (!paused && queue.length) {
//       (queue.shift())();
//       if(!paused) {
//         resume();
//       }
//     }
//   }

//   this.useless = function(callback) { return callback(); };

//   this.assert = function assert(value, desc) {
//     var li = document.createElement('li');
//     li.className = value ? 'pass' : 'fail';
//     li.appendChild(document.createTextNode(desc));
//     results.appendChild(li);
//     if(!value) {
//       li.parentNode.parentNode.className = 'fail';
//     }
//     return li;
//   }
// })();

// window.onload = function(){
//   test("非同期テスト１", function() {
//     pause();
//     setTimeout(function() {
//       assert(true, "第１テスト完了");
//       resume();
//     }, 1000);
//   });

//   test("非同期テスト2", function() {    
//     pause();
//     setTimeout(function() {
//       assert(true, "第2テスト完了");
//       resume();
//     }, 1000);
//   });

//   test("非同期テスト3", function() {
//     pause();
//     setTimeout(function() {
//       assert(true, "第3テスト完了");
//       resume();
//     }, 1000);
//   });

//   test("非同期テスト4", function() {
//     pause();
//     setTimeout(function() {
//       var text = 'コールバック';
//       assert(useless(function() { return text; }) === text, "コールバックテスト完了");
//       resume();
//     }, 1000);
//   });
// };

//// 関数の名前を確認する /////
// function nameExsist() { return true; }
// assert(typeof window.nameExsist === 'function', 'nameExsistは定義されている');
// assert(nameExsist.name === 'nameExsist', 'nameExsist()の名前がnameExsitで定義されている');

// // 無名関数の場合は名前が推論されてnameプロパティに入る。
// var canFly = function() { return true; };
// assert(typeof window.canFly === 'function', 'canFlyは定義されている');
// assert(canFly.name === 'canFly', 'canFly()の名前は推論されてcanFlyが入っている');

// // new Function(...) またはFunction(...) で作成すると、 その名前は "anonymous" になる
// assert((new Function).name === 'anonymous', '関数コンストラクターの名前はanonymousになる');

// window.isDeadly = function() { return true; };
// assert(typeof window.isDeadly === 'function', 'isDeadlyは定義されている');

// function outer() {
//   assert(typeof inner === 'function', 'innerは宣言の前にスコープに入っている');
//   function inner() {}
//   assert(typeof inner === 'function', 'innerは宣言の後にスコープに入っている');
//   assert(window.inner === undefined, 'innerはグローバルスコープに入っていない');
// }

// outer();
// assert(window.inner === undefined, 'innerはグローバルスコープに入っていない');

// window.noRelationName = function funcName() { return true; };
// assert(window.noRelationName.name === 'funcName', 'noRelationNameの変数名は関数名ではない');

// //// JavaScriptのスコープはブロックではなく関数によって宣言される。/////
// if(window) {
//   var x = 123;
// }
// alert(x);

// assert(true, '|--------outerの前-------|');
// assert(typeof outer === 'function', 'outer()はスコープ内にある');
// assert(typeof inner === 'function', 'inner()はスコープ内にある');
// assert(typeof a === 'number', 'aはスコープ内にある');
// assert(typeof b === 'number', 'bはスコープ内にある');
// assert(typeof c === 'number', 'cはスコープ内にある');

// function outer() {
//   assert(true, '|--------outerの中。aの前-------|');
//   assert(typeof outer === 'function', 'outer()はスコープ内にある');
//   assert(typeof inner === 'function', 'inner()はスコープ内にある');
//   assert(typeof a === 'number', 'aはスコープ内にある');
//   assert(typeof b === 'number', 'bはスコープ内にある');
//   assert(typeof c === 'number', 'cはスコープ内にある');

//   var a = 1;

//   assert(true, '|--------outerの中。aの後-------|');
//   assert(typeof outer === 'function', 'outer()はスコープ内にある');
//   assert(typeof inner === 'function', 'inner()はスコープ内にある');
//   assert(typeof a === 'number', 'aはスコープ内にある');
//   assert(typeof b === 'number', 'bはスコープ内にある');
//   assert(typeof c === 'number', 'cはスコープ内にある');

//   function inner() { }
//   var b = 2;

//   assert(true, '|--------outerの中。inner()とbの後-------|');
//   assert(typeof outer === 'function', 'outer()はスコープ内にある');
//   assert(typeof inner === 'function', 'inner()はスコープ内にある');
//   assert(typeof a === 'number', 'aはスコープ内にある');
//   assert(typeof b === 'number', 'bはスコープ内にある');
//   assert(typeof c === 'number', 'cはスコープ内にある');

//   if(a == 1) {
//     var c = 3;
//     assert(true, '|--------outerの中。ifの内側-------|');
//     assert(typeof outer === 'function', 'outer()はスコープ内にある');
//     assert(typeof inner === 'function', 'inner()はスコープ内にある');
//     assert(typeof a === 'number', 'aはスコープ内にある');
//     assert(typeof b === 'number', 'bはスコープ内にある');
//     assert(typeof c === 'number', 'cはスコープ内にある');
//   }
//   assert(true, '|--------outerの中。ｃの後-------|');
//   assert(typeof outer === 'function', 'outer()はスコープ内にある');
//   assert(typeof inner === 'function', 'inner()はスコープ内にある');
//   assert(typeof a === 'number', 'aはスコープ内にある');
//   assert(typeof b === 'number', 'bはスコープ内にある');
//   assert(typeof c === 'number', 'cはスコープ内にある');
// }

// outer();

// assert(true, '|--------outerの後-------|');
// assert(typeof outer === 'function', 'outer()はスコープ内にある');
// assert(typeof inner === 'function', 'inner()はスコープ内にある');
// assert(typeof a === 'number', 'aはスコープ内にある');
// assert(typeof b === 'number', 'bはスコープ内にある');
// assert(typeof c === 'number', 'cはスコープ内にある');

/*
Q. テストブロックをコピペする代わりにそれらを含むテスト関数を作成して、必要な時に呼び出すのではどうしていけないのか？
A. スコープは関数によって宣言されるため、別で関数を作成すると、作成した関数からテストしたい関数やその関数内の変数が参照できない。

outerは常にスコープ内で参照できるがinnerは常に参照できない
a, b, cの変数は関数内のローカル変数なので常に参照できなくなる

*/

//// argumentsとthis /////
// function queue(a,b) {
//   console.log(a);
//   console.log(b);
//   console.log(arguments[0]);
//   console.log(arguments[1]);
// }
// queue(100, 200);

// function creep() { return this; }
// assert(creep() === window, 'Creeping in the window');

// var sneak = creep;
// assert(sneak() === window, 'Sneaking in the window');

// var ninja1 = {
//   skulk: creep
// };
// assert(ninja1.skulk() === ninja1, 'The first ninja is skulking');

// var ninja2 = {
//   skulk: creep
// };
// assert(ninja2.skulk() === ninja2, 'The 2nd ninja is skulking');

/*
コンストラクの特殊な能力
・新しい、空のオブジェクトが作成される。
・そのオブジェクトがthisパラメータとしてコンストラクタに渡される。したがって、その新しいオブジェクトがコンストラクタの呼び出しコンテキストになる。
・関数に明示的な戻り値がなければ、その新しいオブジェクトがコンストラクタお値として返される。

*/

// コンストラクタを使った関数呼び出し
// function Ninja() {
//   this.skulk = function() { return this; };
// }

// var ninja1 = new Ninja();
// var ninja2 = new Ninja();
// assert(ninja1.skulk() === ninja1, 'The 1st ninja is skulking');
// assert(ninja2.skulk() === ninja2, 'The 2nd ninja is skulking');

// function juggle() {
//   var result = 0;
//   for (var n = 0; n < arguments.length; n++) {
//     result += arguments[n];
//   }
//   this.result = result;
// }

// var ninja1 = {};
// var ninja2 = {};

// // applyは引数群を配列で渡す
// juggle.apply(ninja1, [1,2,3,4]);
// // callは引数群をリストで渡す
// juggle.call(ninja2, 5,6,7,8);
// assert(ninja1.result === 10, 'apply');
// assert(ninja2.result === 26, 'call');

// function forEach(list, callback){
//   for (let n = 0; n < list.length; n++) {
//     callback.call(list[n], n);
//   }
// }
// let weapons = ['shuriken', 'katana', 'nunchucks'];

// forEach(weapons, function(index) {
//   assert(this == weapons[index], weapons[index] + 'は期待した値');
// });

// 無名関数の一般的な使い方
// window.onload = function() { assert(true, 'power'); };

// var ninja = {
//   shout: function() {
//     assert(true, 'Ninja');
//   }
// };

// ninja.shout();

// setTimeout(function() { assert(true, 'Forever'); }, 500);

// 名前付き関数での再帰
// function isPalindrome(text) {
//   if(text.length <= 1) return true;
//   if(text.charAt(0) != text.charAt(text.length - 1)) return false;
//   return isPalindrome(text.substr(1, text.length - 2));
// }
// console.log(isPalindrome('シンブンシ'))
// => true

// function chirp(n) {
//   return n > 1 ? chirp(n - 1) + '-chirp' : 'chirp';
// }

// assert(chirp(3) == 'chirp-chirp-chirp', '予想通り');

// let ninja = {
//   chirp: function(n) {
//     return n > 1 ? ninja.chirp(n - 1) + '-chirp' : 'chirp';
//   }
// }
// assert(ninja.chirp(3) == 'chirp-chirp-chirp', '予想通り');

// thisを使うことで参照を維持する。オブジェクトの違いを吸収する
// let ninja = {
//   chirp: function(n) {
//     return n > 1 ? this.chirp(n - 1) + '-chirp' : 'chirp';
//   }
// }
// let samurai = { chirp: ninja.chirp };
// ninja = {}; // 参照が失われる

// try {
//   assert(samurai.chirp(3) == 'chirp-chirp-chirp', '予想通り');
// }
// catch {
//   assert(false, 'うまくいかない');
// }

// インライン関数を使うことでプロパティの違いを吸収する
// let ninja = {
//   chirp: function signal(n) {
//     return n > 1 ? signal(n - 1) + '-chirp' : 'chirp';
//   }
// }
// let samurai = { chirp: ninja.chirp };
// ninja = {}; // ninjaを初期化して参照を失わせる

// try {
//   assert(samurai.chirp(3) == 'chirp-chirp-chirp', '予想通り');
// }
// catch {
//   assert(false, 'うまくいかない');
// }

// let ninja = function myNinja() {
//   assert(ninja == myNinja, 'この関数は2つの名前をもつ')
// }
// ninja()

// assert(typeof myNinja == 'undefined', 'その側からは参照できない名前')

// var ninja = {
//   chirp: function(n) {
//     return n > 1 ? arguments.callee(n - 1) + '-chirp' : 'chirp';
//   }
// }
// assert(ninja.chirp(3) == 'chirp-chirp-chirp', 'arguments.calleeはそれ自身');
//
// ただし非推奨なので使わない方がよい。詳細は↓
// https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Functions/arguments/callee

// var obj = {};
// var fn = function() {};
// obj.prop = 'hitsuke(destraction)';
// fn.prop = 'tanuki(climbing)';

// console.log(obj);
// console.log(fn);
// console.log(obj.prop);
// console.log(fn.prop);

// let store = {
//   nextId: 1, // ←次に割り当てるべきIDを追跡管理する。
//   cache: {}, // ←関数を格納する「キャッシュ」オブジェクトを作成する。
//   add: function(fn){ // 関数がユニークである場合のみキャッシュに関数を追加する
//     if(!fn.id){
//       fn.id = store.nextId++
//       return !!(store.cache[fn.id] = fn)
//     }
//   }
// };

// function ninja() {}
// console.log(ninja.id)
// assert(store.add(ninja), '関数は安全に追加された')
// console.log(ninja.id)
// assert(!store.add(ninja), 'ただし追加は一度だけ')

// function isPrime(value){
//   if(!isPrime.answers) isPrime.answers = {};
//   if (isPrime.answers[value] != null) {
//     return isPrime.answers[value];
//   }
//   var prime = value != 1;
//   for(var i = 2; i < value; i++) {
//     if(value % i == 0){
//       prime = false;
//       break;
//     }
//   }
//   return isPrime.answers[value] = prime;
// }

// assert(isPrime(5), '５は素数であること')
// assert(isPrime.answers[5], '答えはキャッシュされていること')

// function getElements(name) {
//   if(!getElements.cache) getElements.cache = {};
//   return getElements.cache[name] =
//     getElements.cache[name] || document.getElementsByTagName(name);
// }
// assert(getElements('ul').length != 0, 'ulのDOMが見つかること');
// assert(getElements.cache['ul'].length != 0, 'ulのDOMがキャッシュされていること');

// var elems = {
//   length: 0,
//   add: function(elem) {
//     Array.prototype.push.call(this, elem);
//   },
//   gather: function(id) {
//     this.add(document.getElementById(id));
//   },
// }

// console.log(elems);
// elems.gather('first');
// console.log(elems);
// assert(elems.length == 1 && elems[0].nodeType, '要素の獲得を確認');
// elems.gather('second');
// console.log(elems);
// assert(elems.length == 2 && elems[1].nodeType, 'もう一つの挿入を確認');

// function smallest(array) {
//   return Math.min.apply(Math, array);
// }
// function largest(array) {
//   return Math.max.apply(Math, array);
// }

// assert(smallest([0,1,2,3,]) == 0, '最小値の0を返すこと');
// assert(largest([0,1,2,3,]) == 3, '最大値の3を返すこと');

// function merge(root) {
//   for (let i = 0; i < arguments.length; i++) {
//     for (let key in arguments[i]) {
//       root[key] = arguments[i][key];
//     }
//   }
//   return root;
// }

// let merged = merge({name: 'hiro'}, {city: 'Tokyo'});
// assert(merged.name == 'hiro', '元の名前と同じ');
// assert(merged.city == 'Tokyo', 'cityもコピーされている');

// function multiMax(multi) {
//   return multi * Math.max.apply(Math, Array.prototype.slice.call(arguments, 1));
// }
// assert(multiMax(3,1,2,3) == 9, '3*3=9 最初の引数が最大値');

// 関数のlengthプロパティ
// function makeNinja(name) {}
// function makeSamurai(name, rank) {}
// assert(makeNinja.length == 1, '1個の引数を期待している');
// assert(makeSamurai.length == 2, '2個の引数を期待している');

// function addMethod(object, name, fn){
//   let def = object[name];
//   object[name] = function(){
//     if (fn.length == arguments.length) {
//       return fn.apply(this, arguments);
//     } else if(typeof def == 'function'){
//       return def.apply(this, arguments);
//     }
//   }
// }

// let ninja = {
//   values: ["Dean Edwards", "Sam Stephenson", "Alex Russell"]
// };

// addMethod(ninja, 'find', function(){
//   return this.values;
// });

// addMethod(ninja, 'find', function(name){
//   let ret = [];
//   for (let i = 0; i < this.values.length; i++) {
//     if(this.values[i].indexOf(name) == 0){
//       ret.push(this.values[i]);
//     }
//   }
//   return ret;
// });

// addMethod(ninja, 'find', function(firstName, lastName){
//   let ret = [];
//   for (let i = 0; i < this.values.length; i++) {
//     if(this.values[i] == (`${firstName} ${lastName}`)){
//       ret.push(this.values[i]);
//     }
//   }
//   return ret;
// });

// assert(ninja.find().length == 3, 'すべての忍者を見つけた');
// assert(ninja.find("Sam").length == 1, 'first nameの忍者を見つけた');
// assert(ninja.find("Alex", "Russell").length == 1, '姓と名で忍者を見つけた');
// assert(ninja.find("Alex", "Russell", "Jr") == null, 'No忍者');

//////// クロージャ ////////
/*
クロージャは関数と密接な関係。
クロージャを使えば、ページに高度な機能を追加するのに必要なスクリプトの量や複雑さを軽減できる。
実現不可能な（あるいは複雑すぎて手に負えない）機能も実装可能。
*/

// クロージャとは関数が外部変数にアクセスし操作することを可能にするスコープ

// let outerValue = 'ninja';
// let later;

// function outerFunction(){
//   let innerValue = 'samurai';

//   function innerFunction(paramValue){
//     assert(outerValue, 'ninjaが見える');
//     assert(innerValue, 'samuraiが見える');
//     assert(paramValue, '内側からparamValueの値が見える');
//     assert(tooLate, '内側からtooLateの値が見える');
//   }

//   later = innerFunction;
// }

// // assert(!tooLate, '外からtooLateは見えない'); letだとこれはエラーになるのでコメントアウト。var宣言だと大丈夫
// let tooLate = 'rouin';

// outerFunction();
// later('paramValue');

// function Ninja(){
//   let feints = 0;

//   this.getsFeints = function(){
//     return feints;
//   };

//   this.feint = function(){
//     feints++;
//   };
// }

// let ninja = new Ninja();
// assert(ninja.getsFeints() == 0, 'フェイント回数をアクセサから読み出せる. インクリメント前');
// ninja.feint(); // 内部変数のfeintsをインクリメント

// assert(ninja.getsFeints() == 1, 'フェイント回数をアクセサから読み出せる');
// assert(ninja.feints === undefined, 'プライベートデータはアクセスできない');

//// インターバルタイマのコールバックでクロージャを使う ////
// function animateIt(elementId) {
//   var elem = document.getElementById(elementId);
//   var tick = 0; // アニメーションのtick（ステップ）を追跡管理するためのカウンタを設定する。

//   var timer = setInterval(function() {
//     if (tick < 100) {
//       elem.style.left = elem.style.top = tick + "px";
//       tick++;
//     } else {
//       clearInterval(timer);
//       assert(tick == 100, 'tickはクロージャ経由でアクセスできる');
//       assert(elem, '要素もクロージャ経由でアクセスできる');
//       assert(timer, 'タイマのリファレンスもクロージャ経由で取得できる');
//     }
//   }, 10);
// }

// animateIt('box');

//// 呼び出しコンテキストをバインドする ////
// ボタンの状態を保持するオブジェクトを定義する。ボタンがクリックされたかどうかを追跡管理する
// var button = {
//   clicked: false,
//   // クリックハンドラとして使うメソッドを宣言する。オブジェクトのメソッドなので、thisを使えばそのオブジェクトを参照できる
//   click: function() {
//     console.log(this);
//     this.clicked = true;
//     assert(button.clicked, 'ボタンがクリックされた');
//   }
// };
// var elem = document.getElementById('test');
// elem.addEventListener('click', button.click, false);

// イベントハンドラに特定のコンテキストをバインドして上記の問題を解決する
// function bind(context, name){
//   return function() {
//     return context[name].apply(context, arguments);
//   }
// }
// var button = {
//   clicked: false,
//   click: function() {
//     console.log(this);
//     this.clicked = true;
//     assert(button.clicked, 'ボタンがクリックされた');
//   }
// };
// var elem = document.getElementById('test');
// elem.addEventListener('click', bind(button, 'click'), false);

// Function.prototype.bind = function() {
//   var fn = this;
//   var args = Array.prototype.slice.call(arguments)
//   var object = args.shift();

//   return function() {
//     return fn.apply(object, args.concat(Array.prototype.slice.call(arguments)));
//   }
// };

// var myObject = {};
// function myFunction(){
//   return this == myObject;
// }

// assert(!myFunction(), 'まだコンテキストは設定されていない');

// var aFunction = myFunction.bind(myObject);
// assert(aFunction(), 'コンテキストは設定された');

// Function.prototype.partial = function(){
//   var fn = this, args = Array.prototype.slice.call(arguments);
//   return function(){
//     var arg = 0;
//     for (var i = 0; i < args.length && arg < arguments.length; i++) {
//       if (args[i] === undefined) {
//         args[i] = arguments[arg++];
//       }
//     }
//     return fn.apply(this, args);
//   }
// };
// var delay = setTimeout.partial(undefined, 10);
// delay(function(){ assert(true, 'この関数の呼び出しは、10ms遅延される'); });

// var bindClick = document.body.addEventListener.partial('click', undefined, false);
// bindClick(function(){
//   assert(true, 'カリー化された関数を介して、クリックイベントがバインドされた');
// });

// String.prototype.csv = String.prototype.split.partial(/,\s*/);
// var results = ('Mugen, Jin, Fuu').csv();
// assert(
//   results[0] == 'Mugen' &&
//   results[1] == 'Jin' &&
//   results[2] == 'Fuu',
//   'テキストは正常に分割された'
// );

// Prototypeライブラリがどのように部分適用／カリー化のメソッドを実装しているかの例
// Function.prototype.curry = function() {
//   var fn = this,
//   args = Array.prototype.slice.call(arguments);
//   return function() {
//     return fn.apply(this, args.concat(Array.prototype.slice.call(arguments)));
//   };
// };

// 関数のためのメモ化メソッド
// Function.prototype.memoized = function(key) {
//   this._values = this._values || {}; // 初期化
//   // すでにキャッシュがあったらその値を返す。そうでなければ関数を呼び出し計算された値をキャッシュする
//   return this._values[key] !== undefined ? this._values[key] : this._values[key] = this.apply(this, arguments);
// };

// function isPrime(num) {
//   var prime = num != 1;
//   for (var i = 2; i < num; i++) {
//     if(num % i == 0){
//       prime = false;
//       break;
//     }
//   }
//   return prime;
// }

// assert(isPrime.memoized(5), '関数は機能している：５は素数');
// assert(isPrime._values[5], '答えはキャッシュされている');

// Function.prototype.memoized = function(key) {
//   this._values = this._values || {}; // 初期化
//    // すでにキャッシュがあったらその値を返す。そうでなければ関数を呼び出し計算された値をキャッシュする
//   return this._values[key] !== undefined ?
//     this._values[key] :
//     this._values[key] = this.apply(this, arguments);
// };

// Function.prototype.memorize = function() {
//   // 呼び出しコンテキストをクロージャにするために変数へ代入する。thisはクロージャに含まれない。
//   var fn = this;
//   return function() { // 元の関数をメモ化関数でラップする
//     return fn.memoized.apply(fn, arguments);
//   };
// };

// var isPrime = (function(num) {
//   var prime = num != 1;
//   for (var i = 2; i < num; i++) {
//     if(num % i == 0){
//       prime = false;
//       break;
//     }
//   }
//   return prime;
// }).memorize();

// assert(isPrime(17), '17は素数'); // 通常の関数と同じように呼び出される。呼び出し側でメモ化を意識する必要がない。

// ProtoTypeライブラリにおけるreadAttributeメソッド用のラッパー
// 古い関数をラップして機能の一部を更新する。
// function wrap(object, method, wrapper) {
//   var fn = object[method];

//   return object[method] = function() {
//     return wrapper.apply(this, [fn.bind(this)].concat(Array.prototype.slice.call(arguments)));
//   };
// }

// if(Prototype.Browser.Opera) {
//   wrap(Element.Methods, 'readAttribute', function(original, elem, attr) {
//     return attr == 'title' ? elem.title : original(elem, attr);
//   });
// }

//// 即時関数 ////
// 式全体に適用する()は演算子
// (function() {})()
// var someFunction = function(){ ... };
// result = someFunction();
// // ↓
// var someFunction = function(){ ... };
// // (someFunction)のカッコは区切りのカッコで演算子ではない
// result = (someFunction)();

// 1. 関数のインスタンスを作る
// 2. その関数を実行する
// 3. その関数を捨てる（文の実行終了後はもう参照しないため）

// 一時的なスコープとプライベート変数

// numClicks変数は他のどこからも参照できない
// (function() {
//   var numClicks = 0;
//   document.addEventListener('click', function(){
//     alert(++numClicks);
//   }, false);
// })();

// 即時関数である機能を囲い込むシンプルなラッパーが作れる。モジュール化に最適
// document.addEventListener('click', function() {
//   var numClicks = 0;
//   return function() {
//     alert(++numClicks);
//   };
// })(), false;

// $ = function() { alert('jQueryじゃない！')};

// (function($) {
//   $('img').on('click', function(event){
//     $(event.target).addClass('clickdOn');
//   });
// })(jQuery);

// クロージャ内のイテレーターが思ったように動作しないコード
// var divs = document.getElementsByTagName('div');

// for (var i = 0; i < divs.length; i++) {
//   // クロージャに入っている変数iは、変数への参照であって作成されたときの値ではない
//   divs[i].addEventListener('click', function() {
//     alert('div' + i + '番目がクリックされました');
//   }, false);
// }

// クロージャと即時関数を組み合わせてスコープを細かく調整することができる
// var divs = document.getElementsByTagName('div');

// for (var i = 0; i < divs.length; i++) (function(n) {
//   divs[n].addEventListener('click', function() {
//     alert('div' + n + '番目がクリックされました');
//   }, false);
// })(i);

// ライブラリのラッピング
// (function() {
//   var jQuery = window.jQuery = function() {
//     // 初期化処理
//   };
//   // ...
// })();

// var jQuery = (function() {
//   function jQuery(){
//     // 初期化処理
//   }
//   // ...
//   return jQuery;
// })();

// 実体化とプロトタイプ
function Ninja() {} // 何もせず何も返さない関数

Ninja.prototype.swingSword = function() {
  return true;
};

var ninja1 = Ninja();
assert(ninja1 === undefined, 'Ninjaインスタンスは作成されていない');

var ninja2 = new Ninja();
assert(ninja2 &&
  ninja2.swingSword &&
  ninja2.swingSword(), 'Ninjaインスタンスが存在し、メソッドを呼び出せる');
