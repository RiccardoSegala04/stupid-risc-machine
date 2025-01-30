#include "stupid-risc-machine.customasm"
#include "util.customasm"

#bank progmem

start:
    ldl r1, #$
    ldl r1, #$
    ldl r1, #$
    ldl r1, #$
    ldl r1, #$
    adc r1, r3, r4
before:
    ldl r1, #0x1234[15:8]
same:
    

    jmp #start, r1

#addr 0x790
inrange:
jgt #before
#addr 0x1800
outrange:
;jgt #before
