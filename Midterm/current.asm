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
;  File name: current.asm
;  Language: X86-64
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

global current
extern printf

segment .data

prompt_first db "The current on the first circuit is %1.5lf amps." ,10 ,0
prompt_second db "The current on the second circuit is %1.5lf amps." ,10 ,0
prompt_third db "The total current is %1.5lf amps" ,10 ,0


segment .bss
    align 64
    backup_storage_area resb 832

segment .text
current:
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

    movsd     xmm15, xmm0 ; xmm0 holds the first user inputted value and puts a copy into xmm15
    movsd     xmm12, xmm0 ; xmm0 holds the first user inputted value and puts a copy into xmm12
    movsd    xmm14, xmm1   ; xmm1 holds the second user inputted value and puts a copy into xmm14
    movsd     xmm13, xmm2  ; xmm2 holds the third user inputted value and puts a copy into xmm13

    ;calculate I1
    divsd xmm15, xmm14

    ; Output the calculated I1
    mov     rax, 1
    mov     rdi, prompt_first
    movsd   xmm0, xmm15
    call    printf  

    ;calculate I2
    divsd xmm12, xmm13

    ; Output the calculated I2
    mov     rax, 1
    mov     rdi, prompt_second
    movsd   xmm0, xmm12
    call    printf  

    ;calculate I
    addsd xmm15, xmm12

    ; Output the calculated I
    mov     rax, 1
    mov     rdi, prompt_third
    movsd   xmm0, xmm15
    call    printf  

;push result onto the stack
push        qword 0
movsd       [rsp], xmm15

;Restore the values to non-GPRs
mov         rax,7   
mov         rdx,0
xrstor      [backup_storage_area]

;Send back the computed mean to electricity.asm
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