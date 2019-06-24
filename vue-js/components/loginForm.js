var Vue = require('vue')

module.exports = Vue.extend({
    template: '#login-template',
    data: function() {
        return {
            userid: '',
            password: ''
        }
    },
    methods: {
        login: function(){
            return { userid: this.userid, password: this.password }
        }
    },
})
