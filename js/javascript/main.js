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

assert(true, '|--------outerの前-------|');
assert(typeof outer === 'function', 'outer()はスコープ内にある');
assert(typeof inner === 'function', 'inner()はスコープ内にある');
assert(typeof a === 'number', 'aはスコープ内にある');
assert(typeof b === 'number', 'bはスコープ内にある');
assert(typeof c === 'number', 'cはスコープ内にある');

function outer() {
  assert(true, '|--------outerの中。aの前-------|');
  assert(typeof outer === 'function', 'outer()はスコープ内にある');
  assert(typeof inner === 'function', 'inner()はスコープ内にある');
  assert(typeof a === 'number', 'aはスコープ内にある');
  assert(typeof b === 'number', 'bはスコープ内にある');
  assert(typeof c === 'number', 'cはスコープ内にある');

  var a = 1;

  assert(true, '|--------outerの中。aの後-------|');
  assert(typeof outer === 'function', 'outer()はスコープ内にある');
  assert(typeof inner === 'function', 'inner()はスコープ内にある');
  assert(typeof a === 'number', 'aはスコープ内にある');
  assert(typeof b === 'number', 'bはスコープ内にある');
  assert(typeof c === 'number', 'cはスコープ内にある');

  function inner() { }
  var b = 2;

  assert(true, '|--------outerの中。inner()とbの後-------|');
  assert(typeof outer === 'function', 'outer()はスコープ内にある');
  assert(typeof inner === 'function', 'inner()はスコープ内にある');
  assert(typeof a === 'number', 'aはスコープ内にある');
  assert(typeof b === 'number', 'bはスコープ内にある');
  assert(typeof c === 'number', 'cはスコープ内にある');

  if(a == 1) {
    var c = 3;
    assert(true, '|--------outerの中。ifの内側-------|');
    assert(typeof outer === 'function', 'outer()はスコープ内にある');
    assert(typeof inner === 'function', 'inner()はスコープ内にある');
    assert(typeof a === 'number', 'aはスコープ内にある');
    assert(typeof b === 'number', 'bはスコープ内にある');
    assert(typeof c === 'number', 'cはスコープ内にある');
  }
  assert(true, '|--------outerの中。ｃの後-------|');
  assert(typeof outer === 'function', 'outer()はスコープ内にある');
  assert(typeof inner === 'function', 'inner()はスコープ内にある');
  assert(typeof a === 'number', 'aはスコープ内にある');
  assert(typeof b === 'number', 'bはスコープ内にある');
  assert(typeof c === 'number', 'cはスコープ内にある');
}

outer();

assert(true, '|--------outerの後-------|');
assert(typeof outer === 'function', 'outer()はスコープ内にある');
assert(typeof inner === 'function', 'inner()はスコープ内にある');
assert(typeof a === 'number', 'aはスコープ内にある');
assert(typeof b === 'number', 'bはスコープ内にある');
assert(typeof c === 'number', 'cはスコープ内にある');

/*
Q. テストブロックをコピペする代わりにそれらを含むテスト関数を作成して、必要な時に呼び出すのではどうしていけないのか？
A. スコープは関数によって宣言されるため、別で関数を作成すると、作成した関数からテストしたい関数やその関数内の変数が参照できない。

outerは常にスコープ内で参照できるがinnerは常に参照できない
a, b, cの変数は関数内のローカル変数なので常に参照できなくなる

*/
