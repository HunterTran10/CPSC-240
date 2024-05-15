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
;  File name: isnan.asm
;  Language: X86-64
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

global isnan

true equ 1
false equ 0

segment .data

segment .bss
    align 64
    backup_storage_area resb 832

segment .text
isnan:
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

    mov     r12, rdi    ; r12 holds the random number
    
    ; store 0x7fefffffffffffff in r15
    mov     r15, 0x7fefffffffffffff  
    
    ;compare r12 with r15 to see if it's a nan
    cmp     r12, r15
    jg      nan_number          ; jump to nan_number if r12 is greater than r15
    jmp     not_nan_number      ; if r12 is not a nan, jump to not_nan_number

nan_number:
    ; ;Restore the values to non-GPRs
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup_storage_area]

    ;send 1 back to fill_random_array
    mov     rax, true       
    jmp     final_exit

not_nan_number: 
    ; ;Restore the values to non-GPRs
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup_storage_area]

    ;send 0 back to fill_random_array
    mov     rax, false 
final_exit:
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



