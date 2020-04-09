<template>
  <div id="app">
    <button @click="showAlert">アラートが出るよ</button>
  </div>
</template>

<script>
export default {
  name: 'app',
  data () {
    return {
      message: 'Hello, World'
    }
  },
  methods: {
    showAlert() {
      alert(this.message)
    }
  },
}
</script>

<style>

</style>
