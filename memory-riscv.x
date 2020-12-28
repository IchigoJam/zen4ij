/* zen4ij memory definitions */

MEMORY {
	PROG (rx) : ORIGIN = 0x0801DFFF, LENGTH = 8k
  /* SRAM: 1k?? */
  /* RAM (w)  : ORIGIN = 0x10000000, LENGTH = 1k */
	RAM (w) : ORIGIN = 0x20000000, LENGTH = 1k
}

ENTRY(main);

SECTIONS {
	.text :
	{
		*(.text .text.*);
	} > PROG
	.rodata :
	{
		*(.rodata);
	} > PROG
}
