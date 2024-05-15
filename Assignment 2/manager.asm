;****************************************************************************************************************************
;Program name: "Triangle Side Calculator". This program takes in user inputted values of the lengths of two sides of a      *
; triangle and the size of the angle between those two sides. It then calculates The length of the third side. The three    * 
; input values are validated by suitable checking mechanism. Copyright (C) 2024  Hunter Tran.                               *                                                  
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
;  Program name: Triangle Side Calculator
;  Programming languages: One module in C, two in X86, and one in bash.
;  Date program began: 2024-Jan-18
;  Date of last update: 2024-Feb-23
;  Files in this program: driver.c, manager.asm, isfloat.asm, r.sh.  
;  Testing: Alpha testing completed.  All functions are correct.
;
;Purpose
;  This program takes in user inputted values of the lengths of two sides of a triangle and the size of the angle between those 
;  two sides. It then calculates The length of the third side. The three input values are validated by suitable checking mechanism.
;
;This file:
;  File name: manager.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -l manager.lis -o manager.o manager.asm
;  Assemble (debug): nasm -g dwarf -l manager.lis -o manager.o manager.asm
;  Prototype of this function: double compute_triangle();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

global compute_triangle

extern printf
extern fgets
extern stdin
extern strlen
extern scanf
extern cos
extern isfloat
extern atof

name_string_size equ 48
number_size equ 60

segment .data
;This section (or segment) is for declaring initialized arrays

starting_tics db "The starting time on the system clock is %lu tics",10,10,0
enter_name db "Please enter your name:  ",0
enter_title db 10,"Please enter your title (Sargent, Chief, CEO, President, Teacher, etc):  ",0
good_morning_message db 10,"Good morning %s %s.   We take care of all your triangles.  ", 10, 10, 0
first_length db "Please enter the length of the first side:  ", 0
second_length db "Please enter the length of the second side:   ",0
angle_size db "Please enter the size of the angle in degrees:   ",0
thank_you_message db 10,"Thank you %s.  You entered %1.6lf   %1.6lf   and   %1.6lf.",0 
length_output db 10,10,"The length of the third side is  %1.6lf",0 
sent_output db 10,10,"This length will be sent to the driver program.",10,0
final_tics db 10,"The final time on the system clock is %lu tics",0
goodbye_message db 10,10,"Have a good day %s %s.",10, 0  
try_again_message db "Invalid input.  Try again:  ",0

const_float_two dq 2.0
const_float_180 dq 180.0
const_float_pi dq 3.141592653

format db "%lf",0


segment .bss
;This section (or segment) is for declaring empty arrays

align 64

backup_storage_area resb 832

input_name resb name_string_size
input_title resb name_string_size

input_first_side_length resb number_size
input_second_side_length resb number_size
input_angle_size resb number_size

segment .text

compute_triangle:

;Back up the GPRs (General Purpose Registers)
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

;Backup the registers other than the GPRs
mov rax,7
mov rdx,0
xsave [backup_storage_area]

;get starting time on the system clock
cpuid
rdtsc
shl rdx, 32
add rdx, rax 
mov r14, rdx 

;Output the starting time on the system clock
mov rax,0
mov rdi, starting_tics
mov rsi, r14
call printf

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

; Output second instruction for the user (Please enter your title (Sargent, Chief, CEO, President, Teacher, etc))
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

;print out good morning message
mov rax,0
mov rdi, good_morning_message
mov rsi, input_title 
mov rdx, input_name
call printf

;Output third instruction for the user (Please enter the length of the first side)
mov rax, 0
mov rdi, first_length
call printf

begin_first_length_input_loop:
;get user input for first side length
mov rax, 0
mov rdi, input_first_side_length
mov rsi, number_size
mov rdx, [stdin]
call fgets

;Remove newline
mov rax, 0
mov rdi, input_first_side_length
call strlen
mov [input_first_side_length+rax-1], byte 0

; Check if the first side length input is a float and if rax = 0 then jump to first_length_bad_input
mov rax, 0
mov rdi, input_first_side_length
call isfloat
cmp rax, 0
je first_length_bad_input

;convert first side length from string to float and jump to second_length_input
mov rax, 0
mov rdi, input_first_side_length
call atof
movsd xmm15, xmm0 ;xmm15 holds user inputted first side length
jmp second_length_input

;Block that prints try again message and jumps to the begin_first_length_input_loop loop
first_length_bad_input:
mov rax, 0
mov rdi, try_again_message
call printf
jmp begin_first_length_input_loop

second_length_input:
; Output fourth instruction for the user (Please enter the length of the second side)
mov rax, 0
mov rdi, second_length
call printf

begin_second_length_input_loop:
;get user input for second side length
mov rax, 0
mov rdi, input_second_side_length
mov rsi, number_size
mov rdx, [stdin]
call fgets

;Remove newline
mov rax, 0
mov rdi, input_second_side_length
call strlen
mov [input_second_side_length+rax-1], byte 0

; Check if the second side length input is a float and if rax = 0 then jump to second_length_bad_input
mov rax, 0
mov rdi, input_second_side_length
call isfloat 
cmp rax, 0
je second_length_bad_input

;convert second side length from string to float and jump to angle_size_input
mov rax, 0
mov rdi, input_second_side_length
call atof
movsd xmm14, xmm0 ;xmm15 holds user inputted second side length
jmp angle_size_input

;Block that prints try again message and jumps to the begin_second_length_input_loop loop
second_length_bad_input:
mov rax, 0
mov rdi, try_again_message
call printf
jmp begin_second_length_input_loop

angle_size_input:
; Output fifth instruction for the user (Please enter the size of the angle in degrees)
mov rax, 0
mov rdi, angle_size
call printf

begin_angle_size_input_loop:
;get user input for angle size in degrees
mov rax, 0
mov rdi, input_angle_size
mov rsi, number_size
mov rdx, [stdin]
call fgets

;Remove newline
mov rax, 0
mov rdi, input_angle_size
call strlen
mov [input_angle_size+rax-1], byte 0

; Check if the angle size input is a float and if rax = 0 then jump to angle_length_bad_input
mov rax, 0
mov rdi, input_angle_size
call isfloat
cmp rax, 0
je angle_size_bad_input

;convert angle size from string to float and jump to continue_program
mov rax, 0
mov rdi, input_angle_size
call atof
movsd xmm13, xmm0 ;xmm15 holds user inputted angle size
jmp continue_program

;Block that prints error message and jumps to the begin_angle_size_input_loop loop
angle_size_bad_input:
mov rax, 0
mov rdi, try_again_message
call printf
jmp begin_angle_size_input_loop 

continue_program:
;Formula to calculate third side length: a = sqrt(b^2 + c^2 − 2bc cos(A))
;Block that calculates the first part of the formula(b^2 + c^2)
movsd xmm12, xmm15 ;makes a copy of xmm15 to xmm12
movsd xmm11, xmm14 ;makes a copy of xmm14 to xmm11
movsd xmm10, xmm13 ;makes a copy of xmm13 to xmm10
mulsd xmm12, xmm12 ;multiply the value in xmm12 by itself (b^2) and store it into xmm12
mulsd xmm11, xmm11 ;multiply the value in xmm11 by itself (c^2) and store it into xmm11
addsd xmm12, xmm11 ; add the two squared numbers together (b^2 + c^2) and store it in xmm12

;Block that converts degrees to radians
mulsd xmm10, qword [const_float_pi] ;multiply the value in xmm10 by 3.141592653 and store it in xmm10
divsd xmm10, qword [const_float_180] ;divide the value in xmm10 by 180.0 and store it in xmm10

;Block that calls cos and calculates cos(A)
mov rax, 1
movsd xmm0, xmm10
call cos
movsd xmm10, xmm0 ;xmm10 holds the value of cos(A)

;Block that calculates everything to find a in a = sqrt(b^2 + c^2 − 2bc cos(A))
movsd xmm9, xmm15 ;make a copy of xmm15 to xmm9
mulsd xmm9, qword [const_float_two] ;multiply the value in xmm9 by 2.0 (2b) and store it in xmm9
mulsd xmm9, xmm14 ; multiply the value in xmm9 by xmm14 to get (2bc) and store it in xmm9
mulsd xmm9, xmm10 ; multiply the value in xmm9 by the value in xmm10 to get (2bc cos(A)) and store it in xmm9
subsd xmm12, xmm9 ;subtract the value in xmm9 from the value in xmm12 to get (b^2 + c^2) - (2bc cos(A)) and store it in xmm12
sqrtsd xmm12, xmm12 ;square root the number in xmm12 to get the third side length and store it in xmm12

; Output thank you message
mov rax, 3
mov rdi, thank_you_message
mov rsi, input_name
movsd xmm0, xmm15
movsd xmm1, xmm14
movsd xmm2, xmm13
call printf

; Output length of the third side
mov rax, 1
mov rdi, length_output
movsd xmm0, xmm12
call printf

; Output "This length will be sent to the driver program."
mov rax, 0
mov rdi, sent_output
call printf


;get final time on the system clock
cpuid
rdtsc
shl rdx, 32
add rdx, rax 
mov r14, rdx 

;Output the final time on the system clock
mov rax,0
mov rdi, final_tics
mov rsi, r14
call printf

;Outputs goodbye message
mov rax, 0
mov rdi, goodbye_message
mov rsi, input_title 
mov rdx, input_name
call printf

;push result onto the stack
push qword 0
movsd [rsp], xmm12

;Restore the values to non-GPRs
mov rax,7   
mov rdx,0
xrstor [backup_storage_area]

;Send back the third side length to driver.c
movsd xmm0, [rsp]
pop rax

;Restore the GPRs
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret
;End of the function compute_triangle ====================================================================