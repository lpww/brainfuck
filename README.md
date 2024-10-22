# brainfuck

a brainfuck interpreter written in zig. check out the [brainfuck spec](https://github.com/sunjay/brainfuck/blob/master/brainfuck.md) for details.

## commands

* build with `zig build`
* run with `zig build run -- examples/hello-world.bf`
* test with `zig build test`

## todo

* large programs are not able to be stored in memory and give a StreamTooLong error
* add test cases

## examples

- [x] bsort (pass stdin eg echo 876545678 | brainfuck path/to/file.bf)
- [x] fib
- [x] hello world
- [x] input
- [x] qsort
- [x] sierpinski
- [ ] 99 bottles
- [ ] hanoi
- [ ] lost kingdom
- [ ] mandel

## zig version

most recently compiled with zig `0.13.0`
