;****************************************************************************************************************************
;Program name: "Random Array Sorter". This program takes in a user inputted array size and fills the array with             *
;  random numbers. It then normalizes it to the range 1.0 to 2.0 and sorts it in ascending order.                           *
;  Copyright (C) 2024  Hunter Tran.                                                                                         *
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
;  Program name: Random Array Sorter
;  Programming languages: One module in C, five in X86, one in C++, and one in bash.
;  Date program began: 2024-Mar-27
;  Date of last update: 2024-Apr-12
;  Files in this program: main.c, executive.asm, fill_random_array.asm, normalize_array.asm, show_array.asm, sort.cpp, isnan.asm, r.sh. 
;  Testing: Alpha testing completed.  All functions are correct.
;
;Purpose 
;  This program takes in a user inputted array size and fills the array with random numbers. It then normalizes it to the range
;  1.0 to 2.0 and sorts it in ascending order.
;
;This file:
;  File name: show_array.asm
;  Language: X86-64
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

global show_array
extern printf

segment .data
    format_header db "IEEE754			Scientific Decimal", 10, 0
    format_output db "0x%016lx      %-18.13g", 10, 0 

segment .bss
    align 64
    backup_storage_area resb 832

segment .text
show_array:
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

    ; output the header
    mov     rax, 0
    mov     rdi, format_header
    call    printf 

begin_loop:
    ;compare and go to exit if r15 is greater than or equal to the max size
    cmp     r15, r14
    jge     exit

    ;output number in the array in hex and scientific format
    mov     rax, 1
    mov     rdi, format_output
    mov     rsi, [r13 + r15 * 8]
    movsd   xmm0, [r13 + r15 * 8]
    call    printf   
    
    ; Increase r15 and go to begin_loop 
    inc     r15
    jmp     begin_loop   

exit:
    ;Restore the values to non-GPRs
    mov     rax,7   
    mov     rdx,0
    xrstor  [backup_storage_area]

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