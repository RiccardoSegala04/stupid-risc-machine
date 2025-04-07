#include "stupid-risc-machine.customasm"
#include "util.customasm"

#bank progmem

RAM_SIZE        = 2048
RX_BUF          = RAM_SIZE - 3 
RX_FEEDBACK_OFF = RAM_SIZE - 2 
RX_CONTROL_OFF  = RAM_SIZE - 1 

start:

; Load UART register addresses

    ldw r2, r10, #RX_BUF
    ldw r3, r10, #uart_read_byte

    ldw r4, r10, #loaded_start


; Read the length of the program

    ; Save Current address and call uart_read_byte
    jmp r3
    ldl r8, #1
    ldw r1, r10, #$+2

    ; Save the most significant 8 bits of the length

    ; Save Current address and call uart_read_byte
    jmp r3
    sl r6, r5, #8
    ldw r1, r10, #$+2

    ; Save the least significant 8 bits of the length
    or r6, r6, r5
    
    add r6, r6, r4
    
; Read the program
__load_loop:

; Load a word into the correct address

    ; Save Current address and call uart_read_byte
    jmp r3
    nop
    ldw r1, r10, #$+2

    ; Save the most significant 8 bits 

    ; Save Current address and call uart_read_byte
    jmp r3
    sl r7, r5, #8
    ldw r1, r10, #$+2

    ; Save the least significant 8 bits 
    or r7, r7, r5

    ; Store the program word into memory
    st r4[#0], r7

    ; Add 1 to the current program memory word pointer
    add r4, r4, r8

    cmp r6, r4
    jgt ##__load_loop
    nop

; Jump to the loaded program

    ldw r1, r10, #loaded_start
    jmp r1
    nop


uart_read_byte:

__wait_ready:
    ld r9, r2[r8] 
    nop
    nop
    nop
    nop
    nop
    nop
    cmp r9, r0
    jeq ##__wait_ready
    nop

    ld r5, r2[r0]
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    st r2[#2], r8

    jmp r1
    nop

loaded_start:

