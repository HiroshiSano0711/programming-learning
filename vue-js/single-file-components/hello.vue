<template>
    <p class="message">
        メッセージ： {{ msg }}
    </p>
</template>

<script>
export default {
    data (){
        return { msg: 'こんにちは' }
    }
}
</script>

<style scoped>
    .message {
        color: red;
    }
</style>
