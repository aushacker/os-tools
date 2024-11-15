MCU   = atmega328p
F_CPU = 16000000UL

.PHONY: clean

all: test1.hex test1.lst

test1.elf: test1.c
	avr-gcc test1.c -o test1.elf -mmcu=$(MCU) -DF_CPU=$(F_CPU) -Os

test1.hex: test1.elf
	avr-objcopy test1.elf -O ihex test1.hex

test1.lst: test1.elf
	avr-objdump --source --line-numbers test1.elf > test1.lst

clean:
	rm -f *.elf *.hex *.lst
