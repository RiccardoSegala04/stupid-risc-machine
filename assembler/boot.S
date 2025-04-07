#include "stupid-risc-machine.customasm"
#include "util.customasm"

#bank progmem

UART_OFF        = 2048

TX_BUF          = UART_OFF - 6 
TX_FEEDBACK_OFF = UART_OFF - 5 
TX_CONTROL_OFF  = UART_OFF - 4

RX_BUF          = UART_OFF - 3 
RX_FEEDBACK_OFF = UART_OFF - 2 
RX_CONTROL_OFF  = UART_OFF - 1 



start:
    ldl r1, #1
    ldw r2, r13, #RX_BUF
    ldw r3, r13, #RX_FEEDBACK_OFF
    ldw r4, r13, #RX_CONTROL_OFF

    ldw r5, r13, #recv_byte

    ldw r12, r13, #after_sizel
    jmp r5
    nop
    after_sizel:

    mov r7, r6

    ldw r12, r13, #after_sizeh
    jmp r5
    nop
    after_sizeh:

    sl r6, r6, #8
    or r7, r7, r6


    ldw r8, r13, #bootloader_end
    add r9, r8, r7

    load_word:

    ldw r12, r13, #after_loadl
    jmp r5
    nop
    after_loadl:

    mov r10, r6

    ldw r12, r13, #after_loadh
    jmp r5
    nop
    after_loadh:
    
    sl r6, r6, #8 
    or r10, r10, r6

    st r8[#0], r10
    
    add r8, r8, r1
    cmp r8, r9
    
    jlt ##load_word
    nop

    ldw r8, r13, #bootloader_end
    jmp r8
    nop
    ;cmp r0, r0
    ;jeq ##bootloader_end
    ;nop


recv_byte:
    __wait_ready:
    ld r11, r3[r0]
    nop
    nop
    nop
    nop
    nop
    cmp r11, r0
    jeq ##__wait_ready
    nop
    ld r6, r2[r0]
    nop
    nop
    nop
    nop
    nop
    st r4[#0], r1
jmp r12
nop

bootloader_end: