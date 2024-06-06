; # Author name: Hunter Tran
; # Author email: huntertran@csu.fullerton.edu
; # Course and section: CPSC240-3
; # Today’s date: May 13, 2024

global Input_dot
extern scanf
extern printf
extern isfloat
extern atof

segment .data
    format_string db "%s", 0
    prompt_try_again db "Try again: ", 0

segment .bss
    align 64
    backup_storage_area resb 832

segment .text
Input_dot:
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

    mov     r13, rdi    ; r13 is the array
    mov     r14, rsi    ; r14 is max # of values in array
    mov     r15, 0      ; r15 is the index of the array
    sub     rsp, 1024   ; Create a 1024 bits temporary space on the stack

begin_loop:
    ;get user input using scanf
    mov     rax, 0
    mov     rdi, format_string
    mov     rsi, rsp
    call    scanf

    ; Check if the input is a float
    mov     rax, 0
    mov     rdi, rsp
    call    isfloat
    cmp     rax, 0
    je      try_again_message

    ; set up call to atof
    mov     rax, 0
    mov     rdi, rsp
    call    atof

    ; Copy the number into the array
    movsd   [r13 + r15 * 8], xmm0

    ; Increase r15, go to begin_loop if r15 is less than the max size
    inc     r15
    cmp     r15, r14
    jl      begin_loop

    ; Jump to exit otherwise
    jmp     exit      

try_again_message:
    ; output try again message and jump to begin_loop
    mov     rax, 0
    mov     rdi, prompt_try_again
    call    printf
    jmp     begin_loop

exit:
    ; Get rid of the 1024 bits temporary space on the stack
    add     rsp, 1024

    ; ;Restore the values to non-GPRs
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup_storage_area]

    ;send the count back to manager.asm
    mov     rax, r15

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