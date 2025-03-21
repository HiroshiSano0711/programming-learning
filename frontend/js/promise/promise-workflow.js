function asyncFunction() {
  return new Promise(function (resolve, reject) {
    setTimeout(function () {
      resolve('Async Hello world');
    }, 10);
  });
}

asyncFunction().then(function (value) {
  console.log(value); // => 'Async Hello world'
}).catch(function (error) {
  console.error(error);
});
