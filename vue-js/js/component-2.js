
var defaultHeaderTemplate = `
    <div>
      <slot name="header">No title</slot>
    </div>
`

var defaultContentTemplate = `
    <div>
      <slot name="content">No contents</slot>
    </div>
`
Vue.component("page-header", {
    template: defaultHeaderTemplate
})

Vue.component("page-content", {
    template: defaultContentTemplate
})

new Vue({
    el: '#fruits-list',
})
