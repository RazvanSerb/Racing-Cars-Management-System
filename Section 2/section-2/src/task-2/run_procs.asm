%include "../include/io.mac"

struc avg
    .quo resw 1
    .remain resw 1
endstruc

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    push eax
; parcurgere pentru prioritate 1
    xor edx, edx
    mov esi, ecx
parse_vector_1:
    push edx
    xor edx, edx
    mov dl, byte [esi + proc.prio]
    mov dh, 1
    cmp dl, dh
    jne jump_elem_current_1
    add word [eax + avg.remain], 1
    xor edx, edx
    mov dx, word [esi + proc.time]
    add word [eax + avg.quo], dx
    jump_elem_current_1:
    pop edx
    add esi, proc_size
    inc edx
    cmp edx, ebx
    jl parse_vector_1
    pusha
    mov edi, eax
    xor ecx, ecx
    mov cx, word [edi + avg.remain]
    xor eax, eax
    cmp ecx, eax
    je jump_division_1
    mov ax, word [edi + avg.quo]
    xor edx, edx
    div ecx
    mov word [edi + avg.quo], ax
    mov word [edi + avg.remain], dx
    jump_division_1:
    popa
; parcurgere pentru prioritate 2
    add eax, avg_size
    xor edx, edx
    mov esi, ecx
parse_vector_2:
    push edx
    xor edx, edx
    mov dl, byte [esi + proc.prio]
    mov dh, 2
    cmp dl, dh
    jne jump_elem_current_2
    add word [eax + avg.remain], 1
    xor edx, edx
    mov dx, word [esi + proc.time]
    add word [eax + avg.quo], dx
    jump_elem_current_2:
    pop edx
    add esi, proc_size
    inc edx
    cmp edx, ebx
    jl parse_vector_2
    pusha
    mov edi, eax
    xor ecx, ecx
    mov cx, word [edi + avg.remain]
    xor eax, eax
    cmp ecx, eax
    je jump_division_2
    mov ax, word [edi + avg.quo]
    xor edx, edx
    div ecx
    mov word [edi + avg.quo], ax
    mov word [edi + avg.remain], dx
    jump_division_2:
    popa
; parcurgere pentru prioritate 3
    add eax, avg_size
    xor edx, edx
    mov esi, ecx
parse_vector_3:
    push edx
    xor edx, edx
    mov dl, byte [esi + proc.prio]
    mov dh, 3
    cmp dl, dh
    jne jump_elem_current_3
    add word [eax + avg.remain], 1
    xor edx, edx
    mov dx, word [esi + proc.time]
    add word [eax + avg.quo], dx
    jump_elem_current_3:
    pop edx
    add esi, proc_size
    inc edx
    cmp edx, ebx
    jl parse_vector_3
    pusha
    mov edi, eax
    xor ecx, ecx
    mov cx, word [edi + avg.remain]
    xor eax, eax
    cmp ecx, eax
    je jump_division_3
    mov ax, word [edi + avg.quo]
    xor edx, edx
    div ecx
    mov word [edi + avg.quo], ax
    mov word [edi + avg.remain], dx
    jump_division_3:
    popa
; parcurgere pentru prioritate 4
    add eax, avg_size
    xor edx, edx
    mov esi, ecx
parse_vector_4:
    push edx
    xor edx, edx
    mov dl, byte [esi + proc.prio]
    mov dh, 4
    cmp dl, dh
    jne jump_elem_current_4
    add word [eax + avg.remain], 1
    xor edx, edx
    mov dx, word [esi + proc.time]
    add word [eax + avg.quo], dx
    jump_elem_current_4:
    pop edx
    add esi, proc_size
    inc edx
    cmp edx, ebx
    jl parse_vector_4
    pusha
    mov edi, eax
    xor ecx, ecx
    mov cx, word [edi + avg.remain]
    xor eax, eax
    cmp ecx, eax
    je jump_division_4
    mov ax, word [edi + avg.quo]
    xor edx, edx
    div ecx
    mov word [edi + avg.quo], ax
    mov word [edi + avg.remain], dx
    jump_division_4:
    popa
; parcurgere pentru prioritate 5
    add eax, avg_size
    xor edx, edx
    mov esi, ecx
parse_vector_5:
    push edx
    xor edx, edx
    mov dl, byte [esi + proc.prio]
    mov dh, 5
    cmp dl, dh
    jne jump_elem_current_5
    add word [eax + avg.remain], 1
    xor edx, edx
    mov dx, word [esi + proc.time]
    add word [eax + avg.quo], dx
    jump_elem_current_5:
    pop edx
    add esi, proc_size
    inc edx
    cmp edx, ebx
    jl parse_vector_5
    pusha
    mov edi, eax
    xor ecx, ecx
    mov cx, word [edi + avg.remain]
    xor eax, eax
    cmp ecx, eax
    je jump_division_5
    mov ax, word [edi + avg.quo]
    xor edx, edx
    div ecx
    mov word [edi + avg.quo], ax
    mov word [edi + avg.remain], dx
    jump_division_5:
    popa
    pop eax
    
    ;; Your code ends here
   
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY