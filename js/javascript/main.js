/*
この学習はECMAScript2015を元にしている。
IE11ではES6がサポートされていないがES6は多くのブラウザで使えるけど、ECMAScript2015で行う。
新しい構文を学ぶことが目的ではなくJavaScriptのオブジェクト、関数、クロージャについて理解することが目的。
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

let store = {
  nextId: 1, // ←次に割り当てるべきIDを追跡管理する。
  cache: {}, // ←関数を格納する「キャッシュ」オブジェクトを作成する。
  add: function(fn){ // 関数がユニークである場合のみキャッシュに関数を追加する
    if(!fn.id){
      fn.id = store.nextId++
      return !!(store.cache[fn.id] = fn)
    }
  }
};

function ninja() {}
console.log(ninja.id)
assert(store.add(ninja), '関数は安全に追加された')
console.log(ninja.id)
assert(!store.add(ninja), 'ただし追加は一度だけ')
