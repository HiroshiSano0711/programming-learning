package main

import "fmt"

func main() {
	// x := 1
	// p := &x
	// var a *int = p
	// fmt.Println(x)
	// fmt.Println(&x)
	// fmt.Println(p)
	// fmt.Println(*p)
	// fmt.Println(&p)
	// fmt.Println(a)
	// fmt.Println(&a)

	// v := 1
	// incr(&v)
	// fmt.Println(v)
	// incr(&v)
	// fmt.Println(v)
	// fmt.Println(incr(&v))

	var x, y int
	fmt.Println(&x == &x, &x == &y, &x == nil)
	fmt.Println(f() == f())
}

func incr(p *int) int {
	*p++
	return *p
}

func f() *int {
	v := 1
	return &v
}

var p = f()
