import { mount } from "@vue/test-utils";
import Message from "../src/components/Message";

describe("Message.test.js", () => {
  let wrapper;
  const createCmp = propsData => mount(Message, { propsData });

  describe("プロパティ", () => {
    it("messageプロパティを持っている", () => {
      wrapper = createCmp({ message: "hello" });
      expect(wrapper.props("message", "hello")).toBeTruthy();
    });

    it("catプロパティは持っていない", () => {
      wrapper = createCmp({ cat: "hello" });
      expect(wrapper.props("cat", "hello")).toBeFalsy();
    });

    it("messageはString型である", () => {
      // spyを使ってconsoleログをチェックする方法。
      let spy = jest.spyOn(console, "error");
      wrapper = createCmp({ message: 1 });
      expect(spy).toBeCalledWith(expect.stringContaining("[Vue warn]: Invalid prop"));
      spy.mockReset();
    });

    describe('バリデーション', () => {
      const message = createCmp().vm.$options.props.message;

      it('messageプロパティはString型であること', () => {
        expect(message.type).toBe(String);
      });

      it('messageプロパティは必須であること', () => {
        expect(message.required).toBeTruthy()
      });

      it('messageは少なくとも2以上の長さであること', () => {
        expect(message.validator && message.validator('a')).toBeFalsy();
        expect(message.validator && message.validator('aa')).toBeTruthy();
      });
    });
  });
});
