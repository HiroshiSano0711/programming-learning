#!/bin/bash

# for debug with gdb command
# $ gcc -g3 9cc tokenizer.c codegen.c parser.c main.c
assert() {
  expected="$1"
  input="$2"

  gcc -o 9cc tokenizer.c codegen.c parser.c main.c
  ./9cc "$input" > tmp.s
  gcc -o tmp tmp.s
  ./tmp
  actual="$?"

  if [ "$actual" = "$expected" ]; then
    echo "$input => $actual"
  else
    echo "$input => $expected expected, but got $actual"
    exit 1
  fi
}

assert 21 "5 + 20 - 4;"
assert 41 "12 + 34 - 5;"
assert 47 "5 + 6 * 7;"
assert 15 "5 * (9-6);"
assert 4 "(3+5) / 2;"
assert 7 "-3 + 5 *2;"
assert 16 "-(3+5) * -2;"
assert 0 "0 == 1;"
assert 1 "42 == 42;"
assert 1 "0 != 1;"
assert 0 "42 != 42;"
assert 1 "0 < 1;"
assert 0 "1 < 1;"
assert 0 "2 < 1;"
assert 1 "0 <= 1;"
assert 1 "1 <= 1;"
assert 0 "2 <= 1;"

assert 1 "1 > 0;"
assert 0 "1 > 1;"
assert 0 "1 > 2;"
assert 1 "1 >= 0;"
assert 1 "1 >= 1;"
assert 0 "1 >= 2;"

assert 10 "a = 2; a * 5;"
assert 10 "foo = 2; bar = 5; foo * bar;"
assert 10 "foo = 2; bar = 5; return foo * bar;"
assert 13 "return 3 + 10;"
assert 26 "return (3 + 10) * 2;"

echo ok
