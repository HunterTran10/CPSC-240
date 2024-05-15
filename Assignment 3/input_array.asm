;****************************************************************************************************************************
;Program name: "Array Calculator". This program takes in user inputted values and puts them into an array. It then          *
;  calculates the mean and variance of the numbers in the array. Copyright (C) 2024  Hunter Tran.                           *
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
;  Program name: Array Calculator
;  Programming languages: Two modules in C, four in X86, one in C++, and one in bash.
;  Date program began: 2024-Mar-1
;  Date of last update: 2024-Mar-15
;  Files in this program: main.c, manager.asm, input_array.asm, output_array.c, compute_mean.asm, compute_variance.cpp, isfloat.asm, r.sh. 
;  Testing: Alpha testing completed.  All functions are correct.
;
;Purpose 
;  This program takes in user inputted values and puts them into an array. It then calculates the mean and variance of the numbers 
;  in the array.
;
;This file:
;  File name: input_array.asm
;  Language: X86-64
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

global input_array
extern scanf
extern printf
extern isfloat
extern atof

segment .data
    format_string db "%s", 0
    prompt_try_again db "The last input was invalid and not entered into the array.", 10, 0

segment .bss
    align 64
    backup_storage_area resb 832

segment .text
input_array:
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

    mov     r13, rdi    ; r13 is the array
    mov     r14, rsi    ; r14 is max # of values in array
    mov     r15, 0      ; r15 is the index of the array
    sub     rsp, 1024   ; Create a 1024 bits temporary space on the stack

begin_loop:
    ;get user input using scanf
    mov     rax, 0
    mov     rdi, format_string
    mov     rsi, rsp
    call    scanf

    ; Check if the input is a Control+D
    cdqe
    cmp     rax, -1
    je      exit

    ; Check if the input is a float
    mov     rax, 0
    mov     rdi, rsp
    call    isfloat
    cmp     rax, 0
    je      try_again_message

    ; set up call to atof
    mov     rax, 0
    mov     rdi, rsp
    call    atof

    ; Copy the number into the array
    movsd   [r13 + r15 * 8], xmm0

    ; Increase r15, go to begin_loop if r15 is less than the max size
    inc     r15
    cmp     r15, r14
    jl      begin_loop

    ; Jump to exit otherwise
    jmp     exit      

try_again_message:
    ; output try again message and jump to begin_loop
    mov     rax, 0
    mov     rdi, prompt_try_again
    call    printf
    jmp     begin_loop

exit:
    ; Get rid of the 1024 bits temporary space on the stack
    add     rsp, 1024

    ; ;Restore the values to non-GPRs
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup_storage_area]

    ;send the count back to manager.asm
    mov     rax, r15

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



