EMU = ghdl

CONSTS = common_const
ENTITIES = ram memory alu execute control reg_file decode writeback rom fetch risc 
TB = alu_tb reg_file_tb decode_tb writeback_tb risc_tb 

TARGETS = $(CONSTS) $(ENTITIES) $(TB)

VHD = $(addsuffix .vhd, $(TARGETS))
OBJS = $(addsuffix .o, $(TARGETS))

WORK = work-obj93.cf

work-obj93.cf: $(VHD) 
	ghdl -c $(VHD) 

%.o: %.vhd $(WORK)
	ghdl -a $<

%_tb: clean $(OBJS)
	ghdl -e $@
	ghdl -r $@ --wave=$@.ghw

clean:
	rm -f *.o $(TB) $(WORK)
