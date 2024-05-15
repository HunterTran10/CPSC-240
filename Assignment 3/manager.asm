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
;  File name: manager.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -l manager.lis -o manager.o manager.asm
;  Assemble (debug): nasm -g dwarf -l manager.lis -o manager.o manager.asm
;  Prototype of this function: double manager();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

global manager
extern printf
extern input_array
extern output_array
extern compute_mean
extern compute_variance

array_size equ 12
segment .data
    prompt1 db "This program will manage your arrays of 64-bit floats", 10, 0 
    prompt2 db "For the array enter a sequence of 64-bit floats separated by white space.",10, 0
    prompt3 db "After the last input press enter followed by Control+D: ", 10, 0
    prompt_receive db 10,"These numbers were received and placed into an array",10,0
    prompt_mean db "The mean of the numbers in the array is %1.6lf" ,10 ,0
    prompt_variance db "The variance of the inputted numbers is %1.6lf" ,10 ,0

segment .bss
    align 64
    backup_storage_area resb 832
    my_array resq array_size

segment .text
manager:
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

    ; Output first prompt (This program will manage your arrays of 64-bit floats)
    mov     rax,0
    mov     rdi, prompt1
    call    printf

    ; Output second prompt (For the array enter a sequence of 64-bit floats separated by white space.)
    mov     rax,0
    mov     rdi, prompt2
    call    printf

    ; Output third prompt (After the last input press enter followed by Control+D:)
    mov     rax,0
    mov     rdi, prompt3
    call    printf

    ; Call input_array  
    mov     rdi, my_array
    mov     rsi, array_size
    call    input_array

    ; Move array count to r15
    mov     r15, rax
    
    ; Output "These numbers were received and placed into an array"
    mov     rax,0
    mov     rdi, prompt_receive
    call    printf

    ; Call output_array
    mov     rax, 0 
    mov     rdi, my_array
    mov     rsi, r15
    call    output_array

    ; Call compute_mean
    mov     rax, 0 
    mov     rdi, my_array
    mov     rsi, r15
    call    compute_mean
    movsd   xmm14, xmm0 ;copy mean to xmm14
    
    ; Output the calculated mean
    mov     rax, 1
    mov     rdi, prompt_mean
    movsd   xmm0, xmm14
    call    printf  

    ; Call compute_variance
    mov     rax, 1
    mov     rdi, my_array
    mov     rsi, r15
    movsd   xmm0, xmm14
    call    compute_variance
    movsd   xmm15, xmm0 ;copy variance to xmm15

    ; Output the calculated variance
    mov     rax, 1
    mov     rdi, prompt_variance
    movsd   xmm0, xmm15
    call    printf  

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
