;****************************************************************************************************************************
;Program name: "240 midterm program". This program takes in user inputted values for Electromagnetic force, Resistance on subcircuit #1, 
; and Resistance on subcircuit #2.
;  It then calculates Current in sub-circuit #1, Current in sub-circuit #2, and Total current in the entire circuit 
; Copyright (C) 2024  Hunter Tran.                     
;                                                                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************


;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Hunter Tran
;  Author email: huntertran@csu.fullerton.edu
;  Author section: 240-03
;  Author CWID: 886474907
;
;Program information
;  Program name: 240 midterm program
;  Programming languages: One module in C, 3 in X86, and one in bash.
;  Date program began: 2024-Mar-20
;  Date of last update: 2024-Mar-20
;  Files in this program: main.c, electricity.asm, current.asm, isfloat.asm, r.sh. 
;  Testing: Alpha testing completed.  All functions are correct.
;
;Purpose 
;  This program takes in user inputted values for Electromagnetic force, Resistance on subcircuit #1, and Resistance on subcircuit #2.
;  It then calculates Current in sub-circuit #1, Current in sub-circuit #2, and Total current in the entire circuit 
;
;This file:
;  File name: electricity.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -l electricity.lis -o electricity.o electricity.asm
;  Assemble (debug): nasm -g dwarf -l electricity.lis -o electricity.o electricity.asm
;  Prototype of this function: double electricity();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

global electricity
extern printf

extern strlen  
extern fgets

extern stdin  

extern isfloat
extern atof  

extern current


number_size equ 60
segment .data
    prompt1 db "Please enter the electric force in the circuit (volts): ",  0 
    prompt2 db "Please enter the resistance in circuit number 1 (ohms): ", 0
    prompt3 db "Please enter the resistance in circuit number 2 (ohms): ", 0
    prompt_thank_you db "Thank you.",10,0
    try_again_message db "Invalid input.  Try again:  ",0

segment .bss
    align 64
    backup_storage_area resb 832

    input_first_volts resb number_size
    input_first_ohms resb number_size
    input_second_ohms resb number_size

segment .text
electricity:
    ; Back up GPRs
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8 
    push    r9 
    push    r10
    push    r11
    push    r12
    push    r13
    push    r14
    push    r15
    pushf

    ;Backup the registers other than the GPRs
    mov     rax, 7
    mov     rdx, 0
    xsave   [backup_storage_area]

    ; Output first prompt (Please enter the electric force in the circuit (volts): )
    mov     rax,0
    mov     rdi, prompt1
    call    printf

begin_volts_input_loop:
;get user input for first volts
mov rax, 0
mov rdi, input_first_volts
mov rsi, number_size
mov rdx, [stdin]
call fgets

;Remove newline
mov rax, 0
mov rdi, input_first_volts
call strlen
mov [input_first_volts+rax-1], byte 0

; Check if the first side length input is a float and if rax = 0 then jump to first_volts_bad_input
mov rax, 0
mov rdi, input_first_volts
call isfloat
cmp rax, 0
je first_volts_bad_input

;convert volts from string to float and jump to first_ohms_input
mov rax, 0
mov rdi, input_first_volts
call atof
movsd xmm15, xmm0 ;xmm15 holds user inputted volts
jmp first_ohms_input

;Block that prints try again message and jumps to the begin_volts_input_loop loop
first_volts_bad_input:
mov rax, 0
mov rdi, try_again_message
call printf
jmp begin_volts_input_loop

first_ohms_input:

    ; Output second prompt (Please enter the resistance in circuit number 1 (ohms):)
    mov     rax,0
    mov     rdi, prompt2
    call    printf

    begin_first_ohms_input_loop:
;get user input for second side length
mov rax, 0
mov rdi, input_first_ohms
mov rsi, number_size
mov rdx, [stdin]
call fgets

;Remove newline
mov rax, 0
mov rdi, input_first_ohms
call strlen
mov [input_first_ohms+rax-1], byte 0

; Check if the second side length input is a float and if rax = 0 then jump to first_ohms_bad_input
mov rax, 0
mov rdi, input_first_ohms
call isfloat 
cmp rax, 0
je first_ohms_bad_input

;convert second side length from string to float and jump to second_ohms_input
mov rax, 0
mov rdi, input_first_ohms
call atof
movsd xmm14, xmm0 ;xmm14 holds user inputted first ohms
jmp second_ohms_input

;Block that prints try again message and jumps to the begin_first_ohms_input_loop loop
first_ohms_bad_input:
mov rax, 0
mov rdi, try_again_message
call printf
jmp begin_first_ohms_input_loop

second_ohms_input:
; Output fifth instruction for the user (Please enter the resistance in circuit number 2 (ohms):)
mov rax, 0
mov rdi, prompt3
call printf

begin_second_ohms_input_loop:
mov rax, 0
mov rdi, input_second_ohms
mov rsi, number_size
mov rdx, [stdin]
call fgets

;Remove newline
mov rax, 0
mov rdi, input_second_ohms
call strlen
mov [input_second_ohms+rax-1], byte 0

; Check if the second ohms input is a float and if rax = 0 then jump to second_ohms_bad_input
mov rax, 0
mov rdi, input_second_ohms
call isfloat
cmp rax, 0
je second_ohms_bad_input

;convert angle size from string to float and jump to continue_program
mov rax, 0
mov rdi, input_second_ohms
call atof
movsd xmm13, xmm0 ;xmm13 holds user inputted second ohms
jmp continue_program

;Block that prints error message and jumps to the begin_second_ohms_input_loop loop
second_ohms_bad_input:
mov rax, 0
mov rdi, try_again_message
call printf
jmp begin_second_ohms_input_loop 

continue_program:

;output thank you message
mov rax, 0
mov rdi, prompt_thank_you
call printf

; call current.asm
    mov rax, 3
    movsd xmm0, xmm15 ;first input
    movsd xmm1, xmm14 ; second input
    movsd xmm2, xmm13 ;third input
    call current
    movsd   xmm15, xmm0 ;move total current to xmm15

    ;push result onto the stack
    push    qword 0
    movsd   [rsp], xmm15

    ; Restore the values to non-GPRs
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup_storage_area]

    ;Send back the variance to main.c
    movsd   xmm0, [rsp]
    pop     rax

    ;Restore the GPRs
    popf          
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     r9 
    pop     r8 
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rbp

    ret