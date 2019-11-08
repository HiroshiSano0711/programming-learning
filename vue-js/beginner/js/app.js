let items = [
    {
        id: 1,
        name: '鉛筆',
        price: 100,
        quantity: 0,
    },
    {
        id: 2,
        name: 'ノート',
        price: 200,
        quantity: 0,
    },
    {
        id: 3,
        name: '消しゴム',
        price: 500,
        quantity: 0,
    },
]

let vm = new Vue({
    el: '#app',
    data: {
        items: items,
        loggedInButton: 'ログイン済みのため購入できます',
        min_purchase_price: 1000,
        tax_rate: 1.08
    },
    filters: {
        withDelimiter: function(value){
            if(!value){ return '0' }
            return value.toString().replace(/(\d)(?=(\d{3})+$)/g, '$1,')
        }
    },
    computed: {
        totalPrice: function(){
            return this.items.reduce(function (sum, item) {
                return sum + (item.price * item.quantity)
            }, 0)
        },
        totalPriceWithTax: function(){
            return Math.floor(this.totalPrice * this.tax_rate)
        },
        canBuy: function(){
            return this.totalPrice >= this.min_purchase_price
        },
        errorMessageclass: function(){
            return { error: !this.canBuy }
        }
    },
    methods: {
        buy: function(){
            alert(this.totalPriceWithTax + '円のお買い上げ')
            this.items.forEach(item => {
                item.quantity = 0
            })
        },
    },
})
