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
;  File name: executive.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -l executive.lis -o executive.o executive.asm
;  Assemble (debug): nasm -g dwarf -l executive.lis -o executive.o executive.asm
;  Prototype of this function: char* executive();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

global executive
extern printf
extern fgets
extern stdin
extern strlen
extern scanf
extern fill_random_array
extern show_array
extern sort
extern normalize_array

name_string_size equ 60
array_size equ 100
segment .data
    enter_name db "Please enter your name: ",0
    enter_title db "Please enter your title (Mr,Ms,Sargent,Chief,Project Leader,etc): ",0
    nice_message db "Nice to meet you %s %s", 10, 10, 0
    prompt1 db "This program will generate 64-bit IEEE float numbers.", 10, 0 
    prompt2 db "How many numbers do you want.  Today’s limit is 100 per customer.  ", 0
    format_integer db "%d", 0
    prompt3 db "Your numbers have been stored in an array.  Here is that array.", 10, 10, 0
    try_again_message db "Invalid input.  Try again:  ",0
    normalized_message db 10, "The array will now be normalized to the range 1.0 to 2.0  Here is the normalized array", 10, 10, 0
    sorted_message db 10, "The array will now be sorted" , 10, 10, 0
    goodbye_message db 10, "Good bye %s.  You are welcome any time.", 10, 0

segment .bss
    align 64
    backup_storage_area resb 832
    input_name resb name_string_size
    input_title resb name_string_size
    random_array resq array_size

segment .text
executive:
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

    ; Output first instruction for the user (Please enter your name)
    mov rax, 0
    mov rdi, enter_name
    call printf

    ;Input user name
    mov rax, 0
    mov rdi, input_name
    mov rsi, name_string_size
    mov rdx, [stdin]
    call fgets

    ;Remove newline
    mov rax, 0
    mov rdi, input_name
    call strlen
    mov [input_name+rax-1], byte 0

    ; Output second instruction for the user (Please enter your title (Mr,Ms,Sargent,Chief,Project Leader,etc))
    mov rax, 0
    mov rdi, enter_title
    call printf

    ;Input user title
    mov rax, 0
    mov rdi, input_title
    mov rsi, name_string_size
    mov rdx, [stdin]
    call fgets

    ;Remove newline
    mov rax, 0
    mov rdi, input_title
    call strlen
    mov [input_title+rax-1], byte 0

    ;print out nice message
    mov rax,0
    mov rdi, nice_message
    mov rsi, input_title 
    mov rdx, input_name
    call printf

    ; Output first prompt (This program will generate 64-bit IEEE float numbers.)
    mov     rax, 0
    mov     rdi, prompt1
    call    printf

    ; Output second prompt (How many numbers do you want.  Today’s limit is 100 per customer.)
    mov     rax,0
    mov     rdi, prompt2
    call    printf

user_array_size:
    ;get user input of array size
    mov     rax, 0
    mov     rdi, format_integer
    mov     rsi, rsp
    call    scanf
    mov     r15, [rsp] ; r15 holds the user inputted array size

    ;jump to bad_input if r15 is a negative number or greater than 100, else jump to continue_program
    cmp     r15, 0
    jl      bad_input
    cmp     r15, 100
    jg      bad_input
    jmp     continue_program

bad_input:
    ; Block that prints try again message and jumps to the user_array_size loop
    mov     rax, 0
    mov     rdi, try_again_message
    call    printf
    jmp     user_array_size
  
continue_program:
    ; Output third prompt (Your numbers have been stored in an array.  Here is that array.)
    mov     rax, 0
    mov     rdi, prompt3
    call    printf

    ; Call fill_random_array  
    mov     rax, 0
    mov     rdi, random_array
    mov     rsi, r15
    call    fill_random_array

    ; Call show_array
    mov     rax, 0 
    mov     rdi, random_array
    mov     rsi, r15
    call    show_array

    ; output "The array will now be normalized to the range 1.0 to 2.0  Here is the normalized array"
    mov     rax, 0
    mov     rdi, normalized_message
    call    printf

    ; Call normalize_array
    mov     rax, 0 
    mov     rdi, random_array
    mov     rsi, r15
    call    normalize_array

    ; Call show_array
    mov     rax, 0 
    mov     rdi, random_array
    mov     rsi, r15
    call    show_array

    ;output "The array will now be sorted"
    mov     rax, 0
    mov     rdi, sorted_message
    call    printf

    ; Call sort
    mov     rax, 0 
    mov     rdi, random_array
    mov     rsi, r15
    call    sort

    ; Call show_array
    mov     rax, 0 
    mov     rdi, random_array
    mov     rsi, r15
    call    show_array

    ; output goodbye message
    mov      rax, 0
    mov      rdi, goodbye_message         
    mov      rsi, input_title
    call     printf

    ; Restore the values to non-GPRs
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup_storage_area]

    ;Send back the user name to main.c
    mov     rax, input_name

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