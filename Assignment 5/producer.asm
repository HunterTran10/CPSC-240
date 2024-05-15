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
;  File name: producer.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -l producer.lis -o producer.o producer.asm
;  Assemble (debug): nasm -g dwarf -l producer.lis -o producer.o producer.asm
;  Prototype of this function: double producer();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

global producer
extern strlen
extern atof
extern sin
extern gcvt 

segment .data
    side1_prompt db "Please enter the length of side 1:  ",0
    side2_prompt db "Please enter the length of side 2:   ", 0  
    angle_prompt db "Please enter the degrees of the angle between:  ", 0 
    triangle_area db "The area of this triangle is  ", 0
    square_feet db " square feet.", 0
    thank_you_message db "Thank you for using a Hunter product.", 0
    newline db 10

    const_float_two dq 2.0
    const_float_180 dq 180.0
    const_float_pi dq 3.141592653

segment .bss
    align 64
    backup_storage_area resb 832

    input_side1 resb 60
    input_side2 resb 60
    input_angle resb 60

    area_output resb 60

segment .text
producer:
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

    ;call strlen for side1_prompt
    mov     rdi, side1_prompt
    call    strlen
    mov     r15, rax

    ; Output first instruction for the user (Please enter a floating point number for the length of side 1:)
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, side1_prompt
    mov     rdx, r15
    syscall

    ;Block that gets user input for the length of side 1
    mov     rax, 0
    mov     rdi, 0
    mov     rsi, input_side1
    mov     rdx, 60
    syscall

    ;call atof and move the value into xmm15
    mov     rdi, input_side1
    call    atof
    movsd   xmm15, xmm0
    
    ;call strlen for side2_prompt
    mov     rdi, side2_prompt
    call    strlen
    mov     r14, rax

    ; Output second instruction for the user (Please enter a floating point number for the length of side 2:)
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, side2_prompt
    mov     rdx, r14
    syscall

    ;Block that gets user input for the length of side 2
    mov     rax, 0
    mov     rdi, 0
    mov     rsi, input_side2
    mov     rdx, 60
    syscall

    ;call atof and move the value into xmm14
    mov     rdi, input_side2
    call    atof
    movsd   xmm14, xmm0

    ;call strlen for angle_prompt
    mov     rdi, angle_prompt
    call    strlen
    mov     r13, rax

    ; Output third instruction for the user (Please enter a floating point number for the degrees of the angle between:)
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, angle_prompt
    mov     rdx, r13
    syscall

    ;Block that gets user input for the angle degree
    mov     rax, 0
    mov     rdi, 0
    mov     rsi, input_angle
    mov     rdx, 60
    syscall

    ;call atof and move the value into xmm13
    mov     rdi, input_angle
    call    atof
    movsd   xmm13, xmm0

    ; area = a * b * sin(c) / 2
    ;Block that converts user inputted degrees to radians
    mulsd   xmm13, qword [const_float_pi] ;multiply the value in xmm13 by 3.141592653 and store it in xmm13
    divsd   xmm13, qword [const_float_180] ;divide the value in xmm13 by 180.0 and store it in xmm13

    ; Block that calls sin on the angle in radians and puts the value in xmm12
    movsd   xmm0, xmm13
    call    sin
    movsd   xmm12, xmm0

    ; calculate area = a * b * sin(c) / 2
    mulsd   xmm15, xmm14 ; a * b
    mulsd   xmm15, xmm12 ; ab * sin(c)
    divsd   xmm15, qword [const_float_two] ; a * b * sin(c) / 2
    movsd   xmm11, xmm15 ; make a copy of the value in xmm15 and put it in xmm11

    ; use gcvt instead of ftoa (gcvt works like ftoa)
    mov     rax, 1
    movsd   xmm0, xmm11
    mov     rdi, 7
    mov     rsi, area_output ;area_output holds the string value
    call    gcvt

    ; Output newline
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, newline
    mov     rdx, 1
    syscall

    ;call strlen for triangle_area
    mov     rdi, triangle_area
    call    strlen
    mov     r11, rax

    ;output "The area of this triangle is  "
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, triangle_area
    mov     rdx, r11
    syscall

    ;get strlen of area_output
    mov     rdi, area_output
    call    strlen
    mov     r10, rax

    ; Output the area
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, area_output
    mov     rdx, r10
    syscall

    ;get strlen of square_feet
    mov     rdi, square_feet
    call    strlen
    mov     r9, rax

    ; Output ( square feet.)
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, square_feet
    mov     rdx, r9
    syscall

    ; Output newline
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, newline
    mov     rdx, 1
    syscall

    ;call strlen for thank_you_message
    mov     rdi, thank_you_message
    call    strlen
    mov     r8, rax
    
    ;output "Thank you for using a Hunter product."
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, thank_you_message
    mov     rdx, r8
    syscall
    
    ;push result onto the stack
    push    qword 0
    movsd   [rsp], xmm15

    ; Restore the values to non-GPRs
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup_storage_area]

    ;Send back to director.c
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