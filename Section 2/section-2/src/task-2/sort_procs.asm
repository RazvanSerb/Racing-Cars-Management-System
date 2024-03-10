%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs
    extern printf

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here

    xor ebx, ebx
    mov esi, edx
    dec eax
parse_vector_1:
    push ebx
    mov ecx, ebx
    inc ecx
    mov edi, esi
    add edi, proc_size
    inc eax
    parse_vector_2:
        push ecx
        compare_prio:
            xor ebx, ebx
            xor ecx, ecx
            mov bl, byte [esi + proc.prio]
            mov cl, byte [edi + proc.prio]
            cmp bl, cl
            jl without_swap
            je compare_time
            jg swap
        compare_time:
            xor ebx, ebx
            xor ecx, ecx
            mov bx, word [esi + proc.time]
            mov cx, word [edi + proc.time]
            cmp bx, cx
            jl without_swap
            je compare_pid
            jg swap
        compare_pid:
            xor ebx, ebx
            xor ecx, ecx
            mov bx, word [esi + proc.pid]
            mov cx, word [edi + proc.pid]
            cmp bx, cx
            jle without_swap
        swap:
            xor ebx, ebx
            xor ecx, ecx
            mov bx, word [esi + proc.pid]
            mov cx, word [edi + proc.pid]
            mov [esi + proc.pid], cx
            mov [edi + proc.pid], bx
            xor ebx, ebx
            xor ecx, ecx
            mov bl, byte [esi + proc.prio]
            mov cl, byte [edi + proc.prio]
            mov [esi + proc.prio], cl
            mov [edi + proc.prio], bl
            xor ebx, ebx
            xor ecx, ecx
            mov bx, word [esi + proc.time]
            mov cx, word [edi + proc.time]
            mov [esi + proc.time], cx
            mov [edi + proc.time], bx
        without_swap:
        pop ecx
        add edi, proc_size
        inc ecx
        cmp ecx, eax
        jl parse_vector_2
    dec eax
    pop ebx
    add esi, proc_size
    inc ebx
    cmp ebx, eax
    jl parse_vector_1
    inc eax

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY