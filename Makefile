EMU = ghdl

ENTITIES_FOLDER = entities/
TB_FOLDER = testbenches/
SIGNALS_FOLDER = signals/

CONSTS = common_const
ENTITIES = ram memory alu execute control reg_file decode writeback hecu risc 
TB = alu_tb writeback_tb risc_tb

CONST_FILES = $(addprefix $(ENTITIES_FOLDER), $(CONSTS))
ENTITY_FILES = $(addprefix $(ENTITIES_FOLDER), $(ENTITIES))
TB_FILES = $(addprefix $(TB_FOLDER), $(TB))

TARGETS = $(CONST_FILES) $(ENTITY_FILES) $(TB_FILES)

VHD = $(addsuffix .vhd, $(TARGETS))
OBJS = $(addsuffix .o, $(TARGETS))

WORK = work-obj93.cf

work-obj93.cf: $(VHD) 
	ghdl -c $(VHD)

%.o: %.vhd $(WORK)
	ghdl -a $<

%_tb: clean $(OBJS)
	ghdl -e $@
	ghdl -r $@ --wave=$(SIGNALS_FOLDER)$@.ghw

%.hex: %.S
	customasm $< -f hexstr -o $@

test: assembler/test.hex risc_tb
	make clean

testgtk: test
	gtkwave $(SIGNALS_FOLDER)risc_tb.ghw conf.gtkw

clean:
	rm -f *.o $(TB) $(WORK)
