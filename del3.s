.data
numbers: 
    .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0

EOL: 
    .asciz "\n"

.equ SWI_PrInt,0x6b @ Write an Integer
.equ SWI_PrStr, 0x69 @ Write a null-ending string
.equ Stdout, 1 @ Set output mode to be Output View

.text
.global main

factorial: 
    STMDB sp!, {lr}

    MUL r9, r3, r9
    SUB r3, r3, #1
    
    CMP r3,  #0
    BGT factorial

    LDMIA sp!, {pc}

loop:
    STMDB sp!, {lr}

    MOV r9, #1

    LDR r3, [r2]
    CMP r3, #0
    BEQ halt
    BL factorial

    MOV r0,#Stdout @ mode is Output view
    MOV r1, r9  @ integer to print
    SWI SWI_PrInt

    mov r0,#Stdout @ mode is Stdout
    ldr r1, =EOL @ end of line
    swi SWI_PrStr
    ADD r2, r2, #4
   
    BL loop

    LDMIA sp!, {pc}
main:
    LDR r2, =numbers
    BL loop

halt:
    BAL halt

.end