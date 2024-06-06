; Author name: Hunter Tran
; Author email: huntertran@csu.fullerton.edu
; Course and section: CPSC240-3
; Today’s date: May 13, 2024

global Dot
extern printf

extern strlen  
extern fgets

extern stdin  

extern isfloat
extern atof  
extern scanf
extern Input_dot
extern current


number_size equ 60
segment .data
    prompt1 db "Please enter two floats separated by ws for the first vector: ",  0 
    prompt2 db "Thank you.   Please enter two floats separated by ws for the second vector: ", 0

    prompt_thank_you db "Thank you.",10, 10,0
    try_again_message db "Try again: ",0

    dot_product db "The dot product is %1.1lf",10,0

    enjoy db "Enjoy your dot product.", 10,0

    format_string db "%s", 0

    

segment .bss
    align 64
    backup_storage_area resb 832

    my_array resq 2
    my_array_one resq 2

segment .text
Dot:
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

    ; Output first prompt 
    mov     rax,0
    mov     rdi, prompt1
    call    printf

    ; Call Input_dot
  
    mov     rdi, my_array
    mov     rsi, 2
    call    Input_dot

    ; Output second prompt 
    mov     rax, 0
    mov     rdi, prompt2
    call    printf

    ; Call Input_dot
  
    mov     rdi, my_array_one
    mov     rsi, 2
    call    Input_dot



; move all to xmm
    movsd   xmm15, [my_array + 0 * 8]
    movsd   xmm14, [my_array + 1 * 8]
    movsd   xmm13, [my_array_one + 0 * 8]
    movsd   xmm12, [my_array_one + 1 * 8]


    mulsd   xmm15, xmm13
    mulsd   xmm14, xmm12

    addsd   xmm15, xmm14


    mov     rax,0
    mov     rdi, prompt_thank_you
    call    printf


    mov     rax, 1
    mov     rdi, dot_product
    movsd   xmm0, xmm15
    call    printf

    mov     rax,0
    mov     rdi, enjoy
    call    printf


        ;push result onto the stack
    push    qword 0
    movsd   [rsp], xmm15

    ; Restore the values to non-GPRs
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup_storage_area]

    ;Send back the variance to main.c
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