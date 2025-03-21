// function getURL(URL) {
//   return new Promise(function (resolve, reject) {
//     var req = new XMLHttpRequest();
//     req.open('GET', URL, true);
//     req.onload = function () {
//       if (req.status === 200) {
//         resolve(req.responseText);
//       } else {
//         reject(new Error(req.statusText));
//       }
//     };
//     req.onerror = function () {
//       reject(new Error(req.statusText));
//     };
//     req.send();
//   });
// }

// // 実行例
// var URL = "http://httpbin.org/get";
// getURL(URL).then(function onFulfilled(value) {
//   console.log(value);
// }).catch(function onRejected(error) {
//   console.error(error);
// });

// function taskA() {
//   console.log("Task A");
// }
// function taskB() {
//   console.log("Task B");
// }
// function onRejected(error) {
//   console.log("Catch Error: A or B", error);
// }
// function finalTask() {
//   console.log("Final Task");
// }
// let promise = Promise.resolve();
// promise
//   .then(taskA)
//   .then(taskB)
//   .catch(onRejected)
//   .then(finalTask);


// チェーンしないと全て同時に呼び出される。結果の順序が変わる。
let aPromise = new Promise(function (resolve) {
  resolve(100);
});

aPromise.then(function (value) {
  return value * 2;
});
aPromise.then(function (value) {
  return value * 2;
});

aPromise.then(function (value) {
  console.log("1: " + value); // => 100
})

// vs
// 2: `then` はpromise chain通り順番に呼び出される
let bPromise = new Promise(function (resolve) {
  resolve(100);
});
bPromise.then(function (value) {
  return value * 2;
}).then(function (value) {
  return value * 2;
}).then(function (value) {
  console.log("2: " + value); // => 100 * 2 * 2
});