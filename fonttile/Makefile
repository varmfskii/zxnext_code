z88tile.nex: z88tile.asm palette.asm tiles.bin
	sjasmplus $<

tiles.bin: font.bin fonttotile
	./fonttotile $< $@

fonttotile: fonttotile.c

distclean:
	rm -f z88tile.nex tiles.bin fonttotile *~
