#include "stupid-risc-machine.customasm"
#include "util.customasm"

#bank progmem

start:
    ldl r1, #0x0001[15:8]
    adc r1, r1, r4
    adc r1, r3, r4

