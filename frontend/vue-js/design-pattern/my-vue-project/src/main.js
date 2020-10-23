import Vue from 'vue'
import App from './Watched.vue'

new Vue({
  el: '#app',
  render: h => h(App)
})

// import Vue from 'vue'
// // import App from './App.vue'
// Vue.config.devtools = true

// const app = new Vue({
//   el: '#app',
//   data: {
//     firstName: 'aaa'
//   }
// })

// app.firstName = 'bbb'
　
// const Student = {
//   firstName: "yamada",
//   lastName: "taro",
//   grades: [50, 95, 70, 65, 35],
//   getFullName() {
//     return `${this.firstName} ${this.lastName}`
//   },
//   getGrades() {
//     return this.grades.reduce((accumulator, grades) => accumulator + grades)
//   },
//   toString() {
//     return `Student ${this.getFullName()} scored ${this.getGrades() / 500}`
//   }
// }

// console.log(Student.toString())

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
