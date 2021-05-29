// import { mount } from '@vue/test-utils';
// import MessageList from '../src/components/MessageList';

// describe('MessageList.test.js', () => {
//   let cmp;

//   beforeEach(() => {
//     cmp = mount(MessageList, {
//       propsData: { messages: ['Cat'] }
//     });
//   });

//   it('has received Cat as the message property', () => {
//     expect(cmp.vm.messages).toEqual(['Cat'])
//   });

//   it('has the expected html structure', () => {
//     expect(cmp.element).toMatchSnapshot()
//   });
// });

import { shallowMount } from "@vue/test-utils";
import App from "../src/App";

describe("App.test.js", () => {
  let cmp;

  beforeEach(() => {
    cmp = shallowMount(App, { // Create a shallow instance of the component
      data: ()=> {
        return {
          messages: ["Cat"]
        }
      }
    }); 
  });

  it('messagesは["Cat"]と等しいこと', () => { // Within cmp.vm, we can access all Vue instance methods
    expect(cmp.vm.messages).toEqual(["Cat"]);
  });

  it("期待されるHTML構造を持っていること", () => {
    expect(cmp.element).toMatchSnapshot();
  });
});
