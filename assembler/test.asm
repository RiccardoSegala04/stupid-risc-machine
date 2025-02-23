#include "stupid-risc-machine.customasm"
#include "util.customasm"

#bank progmem

start:
    mov r1, r0
    mov r2, r0
    ldl r1, #0
    ldl r2, #1
    ldw r5, #loop
loop:
    adc r1, r1, r2
    jmp r5
    nop
    nop