<template>
  <div>
    <h1>{{ message }}</h1>
  </div>
</template>

<script>
export default {
  name: 'Message',
  props: {
    message: String
  }
}
</script>
