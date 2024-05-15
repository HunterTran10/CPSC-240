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
;  File name: compute_mean.asm
;  Language: X86-64
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

global compute_mean
extern scanf
extern printf
extern isfloat
extern atof

segment .data

segment .bss
    align 64
    backup_storage_area resb 832

segment .text
compute_mean:
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


    mov     r13, rdi    ; r13 contains the array
    mov     r14, rsi    ; r14 is max # of values in array
    mov     r15, 0      ; r15 is the index of the array


begin_loop:
    addsd   xmm15, [r13 + r15 * 8] ;add the array numbers together and put it into xmm15
    
    ; Increase r15, go to begin_loop if r15 is less than the max size
    inc     r15
    cmp     r15, r14
    jl      begin_loop   

    ;change the index (r15) into a floating-point number and put it into xmm14, then divide the added array numbers (xmm15) by the index (xmm14)
    mov     rax, 1
    mov     rcx, r15
    cvtsi2sd xmm14, rcx
    divsd    xmm15, xmm14 

;push result onto the stack
push        qword 0
movsd       [rsp], xmm15

;Restore the values to non-GPRs
mov         rax,7   
mov         rdx,0
xrstor      [backup_storage_area]

;Send back the computed mean to manager.asm
movsd       xmm0, [rsp]
pop         rax

    ;Restore the original values to the GPRs
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
