// Vue.component('fruits-item-name', {
//     props: {
//         fruitItem: {
//             type: Object,
//             required: true
//         }
//     },
//     template: '<li>{{ fruitItem.name }}</li>'
// })

// new Vue({
//     el: '#app',
//     data: {
//         fruitItems: [
//             { name: 'りんご' },
//             { name: 'いちご' },
//         ]
//     },
// })

var counterButton = Vue.extend({
    template: '<span>{{ counter }}個 <button v-on:click="addToCart"></button></span>',
    data: function(){
        return {
            counter: 0
        }
    },
    methods: {
        addToCart: function(){
            this.counter += 1
            this.$emit('increment')
        }
    },
})

new Vue({
    el: '#fruits-counter',
    components: {
        'counter-button': counterButton
    },
    data: {
        total: 0,
        fruits: [
            { name: 'りんご' },
            { name: 'いちご' },
        ]
    },
    methods: {
        incrementCartStatus: function(){
            this.total += 1
        }
    }
})
