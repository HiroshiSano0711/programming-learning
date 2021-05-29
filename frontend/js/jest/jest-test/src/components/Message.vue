<template>
  <li class="message">{{ message }}</li>
</template>

<script>
export default {
  props: {
    message: {
      type: String,
      required: true,
      validator: message => message.length > 1
    }
  }
};
</script>
