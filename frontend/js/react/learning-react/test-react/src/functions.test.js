import { test, expect } from "vitest";
import { timesTwo } from "./functions";

test("Multiplies by two", () => {
  expect(timesTwo(4)).toBe(8);
});
