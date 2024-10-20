# brainfuck

a brainfuck interpreter written in zig

## zig version

most recently compiled with zig `0.13.0`

## commands

* build with `zig build`
* run with `zig build run -- examples/hello-world.bf`
* test with `zig build test`

## bugs

* programs are not reading inputs from stdin
* large programs are not able to be stored in memory and give a StreamTooLong error

## examples

- [x] fib
- [x] hello world
- [x] sierpinski
- [ ] 99 bottles
- [ ] bsort
- [ ] hanoi
- [ ] lost kingdom
- [ ] mandel
- [ ] qsort
