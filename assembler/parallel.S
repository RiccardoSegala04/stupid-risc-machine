#include "stupid-risc-machine.customasm"
#include "util.customasm"

#bank progmem

WIDTH   = 128
HEIGHT  = 32
SCALE   = 32
MAX_ITER    = 15

ldl r1, #1
; r1 = 1

ldl r2, #0  
; r2 = py
yloop:
ldl r3, #0  
; r3 = px
    xloop:
        ldw r4, r11, #(2*SCALE)
        sbc r4, r3, r4
        ; r4 = x0

        ldw r6, r11, #(SCALE)
        sl r5, r2, #1
        sbc r5, r5, r6
        ; r5 = y0

        ldl r6, #0
        ; r6 = x
        ldl r7, #0
        ; r7 = y
        ldl r8, #0
        ; r8 = iter

        while:  ; 11
            mul r9, r6, r6
            mul r10, r7, r7
            add r9, r9, r10

            ldw r10, r11, #(SCALE * SCALE * 4)
            cmp r9, r10
            jgt ##endwhile
            nop

            ldw r9, r11, #(MAX_ITER)
            cmp r8, r9
            jgt ##endwhile
            nop
        do:     ; 22
            mul r9, r6, r6
            sr r9, r9, #5

            mul r10, r7, r7
            sr r10, r10, #5
            sbc r9, r9, r10
            add r9, r9, r4
            ; r9 = x_temp

            mul r7, r6, r7
            sr r7, r7, #4
            add r7, r7, r5

            mov r6, r9
            add r8, r8, r1

            cmp r0, r0
            jeq ##while
            nop
        endwhile:   ; 30
        ldw r10, r11, #(MAX_ITER)

        ldl r13, #0x20
        cmp r8, r10
        jlt ##space
        nop
        ldl r13, #0x23
        space:

        ldl r12, #1
        nop
        ldl r12, #0

        add r3, r3, r1
        ldw r10, r11, #(WIDTH+1)
        cmp r3, r10
    jlt ##xloop
    nop

    ldl r13, #0x0A
    ldl r12, #1
    nop
    ldl r12, #0

    add r2, r2, r1
    ldw r10, r11, #(HEIGHT+1)
    cmp r2, r10
jlt ##yloop
nop



cmp r0, r0
end:
jeq ##end
nop
