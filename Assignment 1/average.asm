;****************************************************************************************************************************
;Program name: "Travel Calculator". This program takes in user inputted values of their number of miles traveled and average*
; speed from Fullerton to Santa Ana, Santa Ana to Long Beach, and from Long Beach to Fullerton. It also takes their average *
; speed from city to city. It then calculates the total distance, time, and average speed of their whole trip.              *   
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
;  Program name: Travel Calculator
;  Programming languages: One module in C, one in X86, and one in bash.
;  Date program began: 2024-Jan-18
;  Date of last update: 2024-Feb-2
;  Files in this program: driver.c, average.asm, r.sh.  
;  Testing: Alpha testing completed.  All functions are correct.
;
;Purpose
;  This program takes in user inputted values of their number of miles traveled and average speed from Fullerton to Santa Ana, 
;  Santa Ana to Long Beach, and from Long Beach to Fullerton. It then calculates the total distance, time, and average speed
;  of their whole trip.
;
;This file:
;  File name: average.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -l average.lis -o average.o average.asm
;  Assemble (debug): nasm -g dwarf -l average.lis -o average.o average.asm
;  Prototype of this function: double compute_average();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;Declaration section.  The section has no name other than "Declaration section".  Declare here everything that does
;not have its own place of declaration

extern printf

extern fgets

extern stdin

extern strlen

extern scanf

global compute_average

name_string_size equ 48

segment .data
;This section (or segment) is for declaring initialized arrays

enter1_output db "Thank you %s %s", 10, 10, 0
enter1 db "Please enter your first and last names:   ",0
enter2 db "Please enter your title such as Lieutenant, Chief, Mr, Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc:  ",0
enter3 db "Enter the number of miles traveled from Fullerton to Santa Ana:   ", 0
enter4 db "Enter your average speed during that leg of the trip:   ",0
enter5 db 10,"Enter the number of miles traveled from Santa Ana to Long Beach:   ",0
enter6 db "Enter your average speed during that leg of the trip:   ",0
enter7 db 10,"Enter the number of miles traveled from Long Beach to Fullerton:   ",0
enter8 db "Enter your average speed during that leg of the trip:   ",0

process_message db 10,"The inputted data are being processed", 10, 10, 0

output_total_distance db "The total distance traveled is %1.8lf miles.",10,0
output_time db "The time of the trip is %1.8lf hours",10,0
output_average_speed db "The average speed during this trip is %1.8lf mph.",10,0 

format db "%lf",0

segment .bss
;This section (or segment) is for declaring empty arrays

align 64

backup_storage_area resb 832

user_name resb name_string_size

user1 resb name_string_size

user2 resb name_string_size

segment .text

compute_average:

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

; Output first instruction for the user (Please enter your first and last names)
mov rax, 0
mov rdi, enter1
call printf

;Input user first and last names
mov rax, 0
mov rdi, user1
mov rsi, name_string_size
mov rdx, [stdin]
call fgets

;Remove newline
mov rax, 0
mov rdi, user1
call strlen
mov [user1+rax-1], byte 0

; Output second instruction for the user (Please enter your title such as Lieutenant, Chief, Mr, Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc)
mov rax, 0
mov rdi, enter2
call printf

;Input user title
mov rax, 0
mov rdi, user2
mov rsi, name_string_size
mov rdx, [stdin]
call fgets

;Remove newline
mov rax, 0
mov rdi, user2
call strlen
mov [user2+rax-1], byte 0

;print out thank you message
mov rax,0
mov rdi, enter1_output
mov rsi, user2 
mov rdx, user1
call printf


;Output third instruction for the user (Enter the number of miles traveled from Fullerton to Santa Ana)
mov rax, 0
mov rdi, enter3
call printf

;Block that inputs the number of miles traveled from Fullerton to Santa Ana
mov rax, 0
push qword 0
push qword 0
mov rdi, format
mov rsi, rsp
call scanf
movsd xmm15,[rsp]
pop rax
pop rax


; Output fourth instruction for the user (Enter your average speed during that leg of the trip)
mov rax, 0
mov rdi, enter4
call printf

;Block that inputs the average speed from Fullerton to Santa Ana
mov rax, 0
push qword 0
push qword 0
mov rdi, format
mov rsi, rsp
call scanf
movsd xmm14,[rsp]
pop rax
pop rax


; Output fifth instruction for the user (Enter the number of miles traveled from Santa Ana to Long Beach)
mov rax, 0
mov rdi, enter5
call printf

;Block that inputs the number of miles traveled from Santa Ana to Long Beach
mov rax, 0
push qword 0
push qword 0
mov rdi, format
mov rsi, rsp
call scanf
movsd xmm13,[rsp]
pop rax
pop rax


; Output sixth instruction for the user (Enter your average speed during that leg of the trip)
mov rax, 0
mov rdi, enter6
call printf

;Block that inputs the average speed from Santa Ana to Long Beach
mov rax, 0
push qword 0
push qword 0
mov rdi, format
mov rsi, rsp
call scanf
movsd xmm12,[rsp]
pop rax
pop rax


; Output seventh instruction for the user (Enter the number of miles traveled from Long Beach to Fullerton)
mov rax, 0
mov rdi, enter7
call printf

;Block that inputs the number of miles traveled from Long Beach to Fullerton
mov rax, 0
push qword 0
push qword 0
mov rdi, format
mov rsi, rsp
call scanf
movsd xmm11,[rsp]
pop rax
pop rax


; Output eighth instruction for the user (Enter your average speed during that leg of the trip)
mov rax, 0
mov rdi, enter8
call printf

;Block that inputs the average speed from Long Beach to Fullerton
mov rax, 0
push qword 0
push qword 0
mov rdi, format
mov rsi, rsp
call scanf
movsd xmm10,[rsp]
pop rax
pop rax


;Outputs data process message
mov rax, 0
mov rdi, process_message
call printf

;calculates the total distance (add all the user inputted miles traveled together)
movsd xmm7, xmm15 ;move input value from xmm15 to xmm7 to keep a copy of xmm15
addsd xmm15, xmm13 ;add miles traveled from Fullerton to Santa Ana and Santa Ana to Long Beach and store it in xmm15
addsd xmm15, xmm11 ;add miles traveled from Long Beach to Fullerton to xmm15, which would now have all the miles traveled added together

;Outputs "The total distance traveled is ... miles."
mov rax, 1
mov rdi, output_total_distance
movsd xmm0, xmm15
call printf

;calculates the time of the trip
divsd xmm7, xmm14 ; divide miles traveled from Fullerton to Santa Ana (xmm7), which has a copy of the number in xmm15, by the average speed of this leg (xmm14) and store it in xmm7
divsd xmm13, xmm12 ; divide miles traveled from Santa Ana to Long Beach (xmm13) by the average speed of the leg (xmm12) and store it in xmm13
divsd xmm11, xmm10 ; divide miles traveled from Long Beach to Fullerton (xmm11) by the average speed of the leg (xmm10) and store it in xmm11
addsd xmm13, xmm7 ;add the divided numbers together (xmm13 and xmm7) and store it in xmm13
addsd xmm13, xmm11 ;add xmm11 and xmm13 and store it in xmm13

;Outputs "The time of the trip is ... hours"
mov rax, 1
mov rdi, output_time
movsd xmm0, xmm13
call printf

;Calculates the average speed
divsd xmm15, xmm13 ;divide the total distance traveled by time of the trip and store it in xmm15

;Outputs "The average speed during this trip is ... mph."
mov rax, 1
mov rdi, output_average_speed
movsd xmm0, xmm15
call printf

;push result onto the stack
push qword 0
movsd [rsp], xmm15

;Restore the values to non-GPRs
mov rax,7   
mov rdx,0
xrstor [backup_storage_area]

;Send back the average speed to driver.c
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
;End of the function compute_average ====================================================================