#include "stupid-risc-machine.customasm"
#include "util.customasm"

#bank progmem

start:
ldl r7, #0x69
cmp r0, r0
jeq ##start
