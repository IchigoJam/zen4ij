/* c4ij memory definitions */

MEMORY {
  /* PROG: 512byte no #700-#8FF, 3kbyte on sector6, or 7k full */
     PROG (rx) : ORIGIN = 0x00006400, LENGTH = 7k
  /* PROG (rx) : ORIGIN = 0x00007000, LENGTH = 4k */
  /* SRAM: 1k?? */
  RAM (w)  : ORIGIN = 0x10000000, LENGTH = 1k
}

SECTIONS {
   .text : {
    KEEP(*(.main))
  } > PROG
}
