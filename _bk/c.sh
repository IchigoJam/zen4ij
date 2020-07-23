#zen build-exe src/main.zen --linker-script memory.x -target thumb-freestanding-eabi -mcpu cortex-m0 --strip --emit asm --release-small
zen build-obj src/main.zen -target thumb-freestanding-eabi -mcpu cortex-m0 --strip --emit asm --release-small
arm-none-eabi-gcc main.o -o main -nostartfiles -mthumb -Tmemory.x
arm-none-eabi-objcopy -O binary main main.bin
arm-none-eabi-objdump -D -bbinary -marm -Mforce-thumb2 main.bin
