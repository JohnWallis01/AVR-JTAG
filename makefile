FILENAME = test
DEVICE = atmega328p
PROGRAMMER = arduino
COMPILE = avr-gcc -Wall -Os -mmcu=$(DEVICE)
PORT = COM6
BAUD = 57600
default: compile upload clean

compile:
				$(COMPILE) -c $(FILENAME).c -o $(FILENAME).o
				$(COMPILE) -o $(FILENAME).elf $(FILENAME).o
				avr-objcopy -j .text -j .data -O ihex $(FILENAME).elf $(FILENAME).hex
				avr-size --format=avr --mcu=$(DEVICE) $(FILENAME).elf

upload:
			avrdude -v -p $(DEVICE) -c $(PROGRAMMER) -P $(PORT) -b $(BAUD) -U flash:w:$(FILENAME).hex:i

clean:
			rm $(FILENAME).o
			rm $(FILENAME).elf
			rm $(FILENAME).hex
