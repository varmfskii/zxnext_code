OBJ=speed35.nex speed70.nex speed14.nex speed28.nex speed.nex speed10.nex

%.nex: %.asm
	sjasmplus $^

.PHONY: all clean distclean

all: $(OBJ)

speed35.nex: speed_var.asm
	sjasmplus $^ -DS35

speed70.nex: speed_var.asm
	sjasmplus $^ -DS70

speed14.nex: speed_var.asm
	sjasmplus $^ -DS14

speed28.nex: speed_var.asm
	sjasmplus $^ -DS28

speed.nex: speed.asm

speed10.nex: speed10.asm

clean:
	rm -f *~

distclean: clean
	rm -f $(OBJ)
