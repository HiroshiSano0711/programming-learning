import Vue from 'vue'
import App from './App.vue'

Vue.config.devtools = true
let msg = require('./data.js');
console.log(msg)
console.log(module)

new Vue({
  el: '#app',
  render: h => h(App)
})

// const user = {}
// let fullname = 'tanaka'
// Object.defineProperty(user, 'fullname', {
//   configurable: true,
//   enumerable: true,
//   get() {
//     return fullname
//   },
//   set(v) {
//     fullname = v
//   }
// })

// console.log(user.fullname)
// user.fullname = 'suzuki'
// console.log(user.fullname)
