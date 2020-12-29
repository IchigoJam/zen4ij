# Zen language for IchigoJam

zen4ij - Zen language for IchigoJam!

Let's make programs with Zen language on your PC!  
This tool provide to convert IchigoJam BASIC to bin file.

- Only IchigoJam 1.4b9 or higher for LPC1114 or IchigoJam R

see also  
https://fukuno.jig.jp/2919
https://fukuno.jig.jp/3077

## Minimum example

```zen
export fn main(param: i32) callconv(.C) i32 {
  return param + 1;
}
```

## LED blink

```zen
const ij = @import("std15.zen");

export fn main(param: i32) i32 {
  while (true) {
      ij.led(1);
      ij.wait(10);
      ij.led(0);
      ij.wait(10);
  }
  return 0;
}
```

## Kawakudari game

```zen
const ij = @import("std15.zen");

export fn main() callconv(.C) i32 {
    ij.cls();
    var x: i32 = 15;
    var score: i32 = 0;
    while (true) {
        ij.locate(x, 5);
        ij.putc(236);
        ij.locate(ij.rnd(32), 23);
        ij.putc(.{'*', 10});
        ij.wait(3);
        switch (ij.inkey()) {
            28 => x -= 1,
            29 => x += 1,
            else => {},
        }
        if (ij.scr(x, 5) != 0) {
            break;
        }
        score += 1;
    }
    return score;
}
```

## How to use

Install Zen language https://zen-lang.org/  
Setup c4yj https://github.com/ichigojam/c4ij  
Setup lpc21isp supported sector writing https://github.com/taisukef/lpc21isp  
Edit settings on Makefile for your environment.  
Edit src/main.zen. (examples in src)

```
$ make
```

Run on your IchigoJam rapidly!

## disassemble

```
$ make disasm
```

## for RISC-V

```
$ make buildr
```

## Limitation

putstr doesn't show collect strings

## License

CC BY 4.0 https://ichigojam.net/
