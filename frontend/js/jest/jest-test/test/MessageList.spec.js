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

// import { shallowMount } from "@vue/test-utils";
// import MessageList from "../src/components/MessageList";

// describe("MessageList.test.js", () => {
//   let cmp;

//   beforeEach(() => {
//     cmp = shallowMount(MessageList, { // Create a shallow instance of the component
//       propsData: {
//         messages: ["Cat"]
//       }
//     });
//   });

//   it('equals messages to ["Cat"]', () => { // Within cmp.vm, we can access all Vue instance methods
//     expect(cmp.vm.messages).toEqual(["Cat"]);
//   });

//   it("has the expected html structure", () => {
//     expect(cmp.element).toMatchSnapshot();
//   });
// });

import { mount } from "@vue/test-utils";
import MessageList from "../src/components/MessageList";
import Message from "../src/components/Message";

describe("MessageList.test.js", () => {
  let cmp;

  beforeEach(() => {
    cmp = mount(MessageList, {
      propsData: {
        messages: ["Cat"]
      }
    });
  });

  it('messageプロパティとして["Cat"]を受け取ること', () => {
    expect(cmp.vm.messages).toEqual(["Cat"]);
  });

  it("期待されるHTML構造であること", () => {
    expect(cmp.element).toMatchSnapshot();
  });

  it("MessageListコンポーネントであること", () => {
    expect(cmp.is(MessageList)).toBe(true);
  });
  
  it("Messageコンポーネントが含まれること", () => {
    expect(cmp.findComponent(Message).exists()).toBe(true);
  });

  it("MessageListとMessageの両方はVueインスタンスである", () => {
    expect(cmp.vm).toBeTruthy();
    expect(cmp.findComponent(Message).vm).toBeTruthy();
  });

  it("message要素が存在すること", () => {
    expect(cmp.find(".message").exists()).toBe(true);
  });

  it("Messageコンポーネントは存在しないこと", () => {
    expect(cmp.exists(Message)).toBe(true);
  });

  it('Messageは"message"のクラス属性をセットすること', () => {
    expect(cmp.findComponent(Message).attributes().class).toBe("message");
  });
});
