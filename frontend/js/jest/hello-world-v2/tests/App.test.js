import { shallowMount } from '@vue/test-utils'
import HelloWorld from '../src/components/HelloWorld'

describe('HelloWorldコンポーネントのテスト', ()=>{
  it('propsに正常に値が渡っていること', ()=>{
    let wrapper = shallowMount(HelloWorld, {
      propsData: { msg: 'abc' }
    })
    expect(wrapper.props().msg).toEqual('abc')
  });

  it("期待されるHTML構造であること", () => {
    let wrapper = shallowMount(HelloWorld, {
      propsData: { msg: 'abc' }
    })
    expect(wrapper.element).toMatchSnapshot();
  });
});
