;#include "stupid-risc-machine.customasm"
;#include "util.customasm"
;
;#bank progmem
;
;start:
;    ldl r1, #$
;    ldl r1, #$
;    ldl r1, #$
;    ldl r1, #$
;    ldl r1, #$
;    adc r1, r3, r4
;before:
;    ldl r1, #0x1234[15:8]
;same:
;    
;
;    jmp #start, r1
;
;#addr 0x790
;inrange:
;jgt #before
;#addr 0x1800
;outrange:
;;jgt #before

#include "stupid-risc-machine.customasm"
#include "util.customasm"

#bank progmem

start:
    mov r1, r0
    mov r2, r0
    ldl r1, #3
    ldl r2, #5

    cmp r1, r2
    nop
    nop
nop
    nop
nop
    nop
nop
    nop
nop
    nop
nop
    nop
nop
    nop

loop:
    jmp #loop, r8
    nop


