<!-- Comment
<template>
  <ul>
    <li v-for="message in messages">{{ message }}</li>
  </ul>
</template>

<script>
export default {
  name: "list",
  props: ["messages"]
};
</script>
 -->

<template>
  <ul>
    <Message
      v-for="message in messages"
      :message="message"
    />
  </ul>
</template>

<script>
import Message from './Message'

export default {
  components: {
    Message
  },
  props: ['messages']
}
</script>
