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
;r1
;r2
;r3
;r4
;r5
;r6
;r7
;r8
;r9
;r10
;r11
;r12
;r13
start:
    ldl r1, #1

    ldw r2, r13, #TX_BUF
    ldw r3, r13, #TX_FEEDBACK_OFF
    ldw r4, r13, #TX_CONTROL_OFF

    ldw r11, r13, #tran_byte


loop:

    ldl r8, #0x43
    ldw r12, r13, #tx1
    jmp r11
    nop
    tx1:
    ldl r8, #0x69
    ldw r12, r13, #tx2
    jmp r11
    nop
    tx2:
    ldl r8, #0x61
    ldw r12, r13, #tx3
    jmp r11
    nop
    tx3:
    ldl r8, #0x6f
    ldw r12, r13, #tx4
    jmp r11
    nop
    tx4:
    ldl r8, #0x0a
    ldw r12, r13, #tx5
    jmp r11
    nop
    tx5:

cmp r0, r0
jeq ##loop
nop

tran_byte:
__wait_ready_tx:
    ld r13, r3[r0]
    nop
    nop
    nop
    nop
    nop
    cmp r13, r0
    nop
    nop
    jgt ##__wait_ready_tx
    nop
trans:
    st r2[#0], r8
    st r4[#0], r1
jmp r12
nop

