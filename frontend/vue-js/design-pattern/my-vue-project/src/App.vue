<template>
  <div id="app">
    <button @click="showAlert">アラートが出るよ</button>
  </div>
</template>

<script>
export default {
  name: 'app',
  data() {
    return {
      message: '警告メッセージ'
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
