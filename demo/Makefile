OUTPUT=drive_sna.asm dma.nex joysticks.nex layer1.sna screen3.nex	\
	screen.nex sprite.nex ulascroll.nex

all: $(OUTPUT)

%.nex: %.asm
	sjasmplus $^

%.sna: %.asm
	sjasmplus $^

.PHONY: clean distclean

distclean: clean
	rm -f $(OUTPUT)

clean:
	rm -f *~
