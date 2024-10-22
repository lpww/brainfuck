# brainfuck

a brainfuck interpreter written in zig. check out the [brainfuck spec](https://github.com/sunjay/brainfuck/blob/master/brainfuck.md) for details.

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
- [x] input
- [x] sierpinski
- [ ] 99 bottles
- [ ] bsort (pass stdin eg echo 876545678 | brainfuck path/to/file.bf)
- [ ] hanoi
- [ ] lost kingdom
- [ ] mandel
- [ ] qsort

## zig version

most recently compiled with zig `0.13.0`
