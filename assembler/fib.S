#include "stupid-risc-machine.customasm"
#include "util.customasm"

#bank progmem

init:
    ldl r5, #1
    ldl r6, #1
    ldl r7, #-1

start:
    add r1, r0, r6

    ldl r2, #3
    add r4, r2, rPC 
    cmp r0, r0

    jeq ##fatt

    ldl r3, #64 
w1:
    ldw r2, r13, #0xffff
w2:
    cmp r2, r0
    jgt ##w2
    add r2, r2, r7

    ldl r2, #1

    cmp r3, r0
    jgt ##w1
    add r3, r3, r7

    cmp r0, r0
    jeq ##start
    add r6, r6, r2

fatt:
    ldl r2, #1
    ldw r3, r13, #-1
    
loop:
    mul r2, r2, r1
    add r1, r1, r3
    cmp r1, r0
    jgt ##loop
    nop

    add r5, r2, r0

    jmp r4
    nop
    
