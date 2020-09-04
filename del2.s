.data
test:
    .word 1
    .word 3
    .word 5
    .word 7
    .word 9
    .word 8
    .word 6
    .word 4
    .word 2
    .word 0
textA: .asciz "Lab1 , Assignment 2 \n"
textB: .asciz "The max is "
textC: .asciz "Done \n"
EOL: .asciz "\n"

.equ SWI_PrChr,0x00 @ Write an ASCII char to Stdout
.equ SWI_PrStr, 0x69 @ Write a null-ending string
.equ SWI_PrInt,0x6b @ Write an Integer
.equ Stdout, 1 @ Set output mode to be Output View
.equ SWI_Exit, 0x11 @ Stop execution
.global _start
.text
.global main
/*******************************************************************
Function finding maximum value in a zero terminated integer array
*******************************************************************/
findMax:
    STMDB sp!, {lr} /* PUSH { lr } */

    LDR r10, [r0]
    CMP r10, #0
    BEQ finish

    ADD r0, r0, #4
    LDR r5, [r0]

    CMP r5, r4
    MOVGE r4, r5

    BL findMax
    LDMIA sp!, {pc} /* POP { pc } */

finish:
    STMDB sp!, {lr}

    MOV r0, r4

    LDMIA sp!, {pc}

/**********************
main function
**********************/
main:
    mov R0,#Stdout @ mode is Stdout
    ldr R1, =textA @ load address of Message1
    swi SWI_PrStr @ display message to Stdout

    mov R0,#Stdout @ mode is Stdout
    ldr R1, =textB @ load address of Message1
    swi SWI_PrStr @ display message to Stdout

    LDR r0, = test
    BL findMax

    mov R0,#Stdout @ mode is Output view
    mov r1, r4  @ integer to print
    swi SWI_PrInt

    mov R0,#Stdout @ mode is Stdout
    ldr r1, =EOL @ end of line
    swi SWI_PrStr

    mov R0,#Stdout @ mode is Stdout
    ldr R1, =textC @ load address of Message1
    swi SWI_PrStr @ display message to Stdout

    BL halt
halt:
    BAL halt

.end
