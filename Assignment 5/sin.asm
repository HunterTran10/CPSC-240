;****************************************************************************************************************************
;Program name: "Triangle Area Calculator". This program takes in user inputted values of the lengths of two sides of a      * 
; triangle and the degrees of the angle between those two sides. It then computes the area of a triangle.                   *
; Copyright (C) 2024  Hunter Tran.                                                                                          * 
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
;  Program name: Triangle Area Calculator
;  Programming languages: One module in C, two in X86, and one in bash.
;  Date program began: 2024-Apr-25
;  Date of last update: 2024-May-11
;  Files in this program: director.c, producer.asm, sin.asm, r.sh.  
;  Testing: Alpha testing completed.  All functions are correct.
;
;Purpose
;  This program takes in user inputted values of the lengths of two sides of a triangle and the degrees of the angle between those 
;  two sides. It then computes the area of a triangle.
;
;This file:
;  File name: sin.asm
;  Language: X86-64
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

global sin

segment .data

segment .bss
    align 64
    backup_storage_area resb 832
segment .text

sin:
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

    ;xmm15 and xmm13 holds the user input
    movsd   xmm15, xmm0 ;xmm15 = x
    movsd   xmm13, xmm0 ;xmm13 = x

    xorpd   xmm10, xmm10 ; xmm10 = 0.0

    mulsd   xmm13, xmm13 ; xmm13 = x^2
    mov     r8, -1

    cvtsi2sd xmm12, r8 ; xmm12 = -1.0
    mulsd   xmm13, xmm12 ; xmm13 = -x^2

    ; xmm9 = 2.0
    mov     rax, 2
    cvtsi2sd xmm9, rax

    ; xmm8 = 3.0
    mov     rax, 3
    cvtsi2sd xmm8, rax

    ; r15 = 0, xmm7 = 0.0
    mov     r15, 0          
    cvtsi2sd xmm7, r15 ;xmm7, r15 = term counter

    mov     r14, 10000000  ; move 10,000,000 into r14
begin_loop:
    ;compare r15 with r14(10,000,000), and jump if equal to exit
    cmp     r15, r14
    je      exit
    ;first add the user inputted value into xmm10, and then after each loop, add the multiplied value to xmm10
    addsd   xmm10, xmm15

    ;Work on denominator 
    ;(2n+2)
    movsd   xmm6, xmm9 ;move 2.0 into xmm6
    mulsd   xmm6, xmm7 ;multiply xmm6(2) by term counter
    addsd   xmm6, xmm9 ;add 2.0 to it

    ;(2n+3)
    movsd   xmm5, xmm9 ;move 2.0 into xmm5
    mulsd   xmm5, xmm7 ;multiply xmm5(2) by term counter
    addsd   xmm5, xmm8 ;add 3.0 to it

    ;multiply the two denominator values together
    mulsd   xmm6, xmm5

    ; put -x^2 from xmm13 to xmm4
    movsd   xmm4, xmm13

    ;divide -x^2/(2n+2)(2n+3)
    divsd   xmm4, xmm6

    ;first multiply -x^2/(2n+2)(2n+3) with the user input (xmm15), and after each loop, multiply -x^2/(2n+2)(2n+3) to xmm15
    mulsd   xmm15, xmm4
    
    ;increase r15, convert it to a float, and jump to begin_loop
    inc     r15
    cvtsi2sd xmm7, r15   ;xmm7, r15 = term counter
    jmp     begin_loop
    
exit:
    movsd   xmm0, xmm10 

    ;push result onto the stack
    push    qword 0
    movsd   [rsp], xmm0

    ; Restore the values to non-GPRs
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup_storage_area]

    ;Send back to producer.asm
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