<template>
  <div>
    <input type="number" v-model="id">
    <p>ID: {{ user.id }}</p>
    <p>名前: {{ user.name }}</p>
    <p>メアド: {{ user.email }}</p>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      id: '',
      user: {}
    }
  },
  methods: {
    getDataForUser() {
      axios.get(
        `https://jsonplaceholder.typicode.com/users/${this.id}`
      ).then(res => this.user = res.data)
    }
  },
  watch: {
    id() {
      this.getDataForUser()
    }
  },
}
</script>

<style>

</style>
