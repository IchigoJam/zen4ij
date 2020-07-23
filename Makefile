#!/bin/sh

BAS2BIN="../../c/bas2bin_for_IchigoJam/bas2bin"
LPC21ISP="../../c/lpc21isp_197k/lpc21isp"
USBSERIAL="/dev/tty.SLAB_USBtoUART"

DST=dst
NAME=zen4ij

all: build write

build:
	-mkdir ${DST}
	#zen build-exe src/main.zen --linker-script memory.x -target thumb-freestanding-eabi -mcpu cortex-m0 --strip --emit asm --release-small
	zen build-obj src/main.zen --name ${DST}/${NAME} -target thumb-freestanding-eabi -mcpu cortex-m0 --strip --release-small --emit asm
	arm-none-eabi-gcc ${DST}/${NAME}.o -o ${DST}/${NAME}.axf -nostartfiles -mthumb -Tmemory.x
	arm-none-eabi-objcopy -O ihex ${DST}/${NAME}.axf ${DST}/${NAME}.hex
	arm-none-eabi-objcopy -O binary ${DST}/${NAME}.axf ${DST}/${NAME}.bin
	ls -l ${DST}/${NAME}.bin

clean:
	#rm -r zen-cache
	-rm -r ${DST}

write:
	echo "1 @ARUN:POKE#800,3,180,4,73,8,104,64,28,0,209,3,73,1,49,140,70,3,188,96,71,0,100,0,0,0,116,0,0:?USR(#800)" > ${DST}/entry.bas
	${BAS2BIN} ${DST}/entry.bas ${DST}/entry.bin
	cat ${DST}/entry.bin ${DST}/${NAME}.bin > ${DST}/sector6.bin
	${LPC21ISP} -control -bin -sector6 ${DST}/sector6.bin ${USBSERIAL} 115200 1200

disasm:
	arm-none-eabi-objdump -D -bbinary -marm -Mforce-thumb2 $(DST)/${NAME}.bin
	#objdump -D -marm -Mforce-thumb2 $(DST)/${NAME}.axf
	wc -c < $(DST)/${NAME}.bin
