var assert = require('assert')
var loginForm = require('../components/loginForm')

describe('login', function(){
    var vm
    beforeEach(function(){
        vm = new loginForm().$mount()
    })

    it('check initial value - login()', function(){
        assert.equal(vm.userid, '')
        assert.equal(vm.password, '')
    })

    it('check required value - login()', function(){
        vm.userid = 'testuser'
        vm.password = 'password'
        var result = vm.login()
        assert.deepStrictEqual(result, { userid: 'testuser', password: 'password' })
    })
})
