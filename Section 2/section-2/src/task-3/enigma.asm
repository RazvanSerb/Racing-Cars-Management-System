%include "../include/io.mac"

;; defining constants, you can use these as immediate values in your code
LETTERS_COUNT EQU 26

section .data
    extern len_plain
    ZERO dd 0
    UNO dd 1
    DOI dd 2

section .text
    global rotate_x_positions
    global enigma
    extern printf

; void rotate_x_positions(int x, int rotor, char config[10][26], int forward);
rotate_x_positions:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; x
    mov ebx, [ebp + 12] ; rotor
    mov ecx, [ebp + 16] ; config (address of first_time element in matrix)
    mov edx, [ebp + 20] ; forward
    ;; DO NOT MODIFY
    ;; TODO: Implement rotate_x_positions
    ;; FREESTYLE STARTS HERE

    cmp edx, 0
    jne case_forward_1
    case_forward_0:
        cmp ebx, 0
        jne another_rotor_with_f0
        rotor_with_f0_idx0:
            xor esi, esi
            cmp esi, eax
            jge NO_repeat_for_f0_idx0
            repeat_for_f0_idx0:
                xor ebx, ebx
                mov bl, byte [ecx]
                xor edi, edi
                translation_for_f0_idx0_sir1:
                    xor edx, edx
                    mov dl, byte [ecx + edi + 1]
                    mov [ecx + edi], dl
                    inc edi
                    cmp edi, LETTERS_COUNT - 1
                    jl translation_for_f0_idx0_sir1
                mov [ecx + LETTERS_COUNT - 1], bl
                xor ebx, ebx
                mov bl, byte [ecx + LETTERS_COUNT]
                xor edi, edi
                translation_for_f0_idx0_sir2:
                    xor edx, edx
                    mov dl, byte [ecx + LETTERS_COUNT + edi + 1]
                    mov [ecx + LETTERS_COUNT + edi], dl
                    inc edi
                    cmp edi, LETTERS_COUNT - 1
                    jl translation_for_f0_idx0_sir2
                mov [ecx + 2*LETTERS_COUNT - 1], bl
                inc esi
                cmp esi, eax
                jl repeat_for_f0_idx0
            NO_repeat_for_f0_idx0:
            jmp rotor_finishizat_f0
        another_rotor_with_f0:
        cmp ebx, 1
        jne rotor_with_f0_idx2
        rotor_with_f0_idx1:
            xor esi, esi
            cmp esi, eax
            jge NO_repeat_for_f0_idx1
            repeat_for_f0_idx1:
                xor ebx, ebx
                mov bl, byte [ecx + 2*LETTERS_COUNT]
                xor edi, edi
                translation_for_f0_idx1_sir1:
                    xor edx, edx
                    mov dl, byte [ecx + 2*LETTERS_COUNT + edi + 1]
                    mov [ecx + 2*LETTERS_COUNT + edi], dl
                    inc edi
                    cmp edi, LETTERS_COUNT - 1
                    jl translation_for_f0_idx1_sir1
                mov [ecx + 3*LETTERS_COUNT - 1], bl
                xor ebx, ebx
                mov bl, byte [ecx + 3*LETTERS_COUNT]
                xor edi, edi
                translation_for_f0_idx1_sir2:
                    xor edx, edx
                    mov dl, byte [ecx + 3*LETTERS_COUNT + edi + 1]
                    mov [ecx + 3*LETTERS_COUNT + edi], dl
                    inc edi
                    cmp edi, LETTERS_COUNT - 1
                    jl translation_for_f0_idx1_sir2
                mov [ecx + 4*LETTERS_COUNT - 1], bl
                inc esi
                cmp esi, eax
                jl repeat_for_f0_idx1
            NO_repeat_for_f0_idx1:
            jmp rotor_finishizat_f0
        rotor_with_f0_idx2:
            xor esi, esi
            cmp esi, eax
            jge NO_repeat_for_f0_idx2
            repeat_for_f0_idx2:
                xor ebx, ebx
                mov bl, byte [ecx + 4*LETTERS_COUNT]
                xor edi, edi
                translation_for_f0_idx2_sir1:
                    xor edx, edx
                    mov dl, byte [ecx + 4*LETTERS_COUNT + edi + 1]
                    mov [ecx + 4*LETTERS_COUNT + edi], dl
                    inc edi
                    cmp edi, LETTERS_COUNT - 1
                    jl translation_for_f0_idx2_sir1
                mov [ecx + 5*LETTERS_COUNT - 1], bl
                xor ebx, ebx
                mov bl, byte [ecx + 5*LETTERS_COUNT]
                xor edi, edi
                translation_for_f0_idx2_sir2:
                    xor edx, edx
                    mov dl, byte [ecx + 5*LETTERS_COUNT + edi + 1]
                    mov [ecx + 5*LETTERS_COUNT + edi], dl
                    inc edi
                    cmp edi, LETTERS_COUNT - 1
                    jl translation_for_f0_idx2_sir2
                mov [ecx + 6*LETTERS_COUNT - 1], bl
                inc esi
                cmp esi, eax
                jl repeat_for_f0_idx2
            NO_repeat_for_f0_idx2:
            jmp rotor_finishizat_f0
        rotor_finishizat_f0:
        jmp finish
    case_forward_1:
        cmp ebx, 0
        jne another_rotor_with_f1
        rotor_with_f1_idx0:
            xor esi, esi
            cmp esi, eax
            jge NO_repeat_for_f1_idx0
            repeat_for_f1_idx0:
                xor ebx, ebx
                mov bl, byte [ecx + LETTERS_COUNT - 1]
                xor edi, edi
                mov edi, LETTERS_COUNT - 1
                translation_for_f1_idx_0_sir1:
                    xor edx, edx
                    mov dl, byte [ecx + edi - 1]
                    mov [ecx + edi], dl
                    dec edi
                    cmp edi, 0
                    jg translation_for_f1_idx_0_sir1
                mov [ecx], bl
                xor ebx, ebx
                mov bl, byte [ecx + 2*LETTERS_COUNT - 1]
                xor edi, edi
                mov edi, LETTERS_COUNT - 1
                translation_for_f1_idx_0_sir2:
                    xor edx, edx
                    mov dl, byte [ecx + LETTERS_COUNT + edi - 1]
                    mov [ecx + LETTERS_COUNT + edi], dl
                    dec edi
                    cmp edi, 0
                    jg translation_for_f1_idx_0_sir2
                mov [ecx + LETTERS_COUNT], bl
                inc esi
                cmp esi, eax
                jl repeat_for_f1_idx0
            NO_repeat_for_f1_idx0:
            jmp rotor_finishizat_f1
        another_rotor_with_f1:
        cmp ebx, 1
        jne rotor_with_f1_idx2
        rotor_with_f1_idx1:
            xor esi, esi
            cmp esi, eax
            jge NO_repeat_for_f1_idx1
            repeat_for_f1_idx1:
                xor ebx, ebx
                mov bl, byte [ecx + 3*LETTERS_COUNT - 1]
                xor edi, edi
                mov edi, LETTERS_COUNT - 1
                translation_for_f1_idx1_sir1:
                    xor edx, edx
                    mov dl, byte [ecx + 2*LETTERS_COUNT + edi - 1]
                    mov [ecx + 2*LETTERS_COUNT + edi], dl
                    dec edi
                    cmp edi, 0
                    jg translation_for_f1_idx1_sir1
                mov [ecx + 2*LETTERS_COUNT], bl
                xor ebx, ebx
                mov bl, byte [ecx + 4*LETTERS_COUNT - 1]
                xor edi, edi
                mov edi, LETTERS_COUNT - 1
                translation_for_f1_idx1_sir2:
                    xor edx, edx
                    mov dl, byte [ecx + 3*LETTERS_COUNT + edi - 1]
                    mov [ecx + 3*LETTERS_COUNT + edi], dl
                    dec edi
                    cmp edi, 0
                    jg translation_for_f1_idx1_sir2
                mov [ecx + 3*LETTERS_COUNT], bl
                inc esi
                cmp esi, eax
                jl repeat_for_f1_idx1
            NO_repeat_for_f1_idx1:
            jmp rotor_finishizat_f1
        rotor_with_f1_idx2:
            xor esi, esi
            cmp esi, eax
            jge NO_repeat_for_f1_idx2
            repeat_for_f1_idx2:
                xor ebx, ebx
                mov bl, byte [ecx + 5*LETTERS_COUNT - 1]
                xor edi, edi
                mov edi, LETTERS_COUNT - 1
                translation_for_f1_idx2_sir1:
                    xor edx, edx
                    mov dl, byte [ecx + 4*LETTERS_COUNT + edi - 1]
                    mov [ecx + 4*LETTERS_COUNT + edi], dl
                    dec edi
                    cmp edi, 0
                    jg translation_for_f1_idx2_sir1
                mov [ecx + 4*LETTERS_COUNT], bl
                xor ebx, ebx
                mov bl, byte [ecx + 6*LETTERS_COUNT - 1]
                xor edi, edi
                mov edi, LETTERS_COUNT - 1
                translation_for_f1_idx2_sir2:
                    xor edx, edx
                    mov dl, byte [ecx + 5*LETTERS_COUNT + edi - 1]
                    mov [ecx + 5*LETTERS_COUNT + edi], dl
                    dec edi
                    cmp edi, 0
                    jg translation_for_f1_idx2_sir2
                mov [ecx + 5*LETTERS_COUNT], bl
                inc esi
                cmp esi, eax
                jl repeat_for_f1_idx2
            NO_repeat_for_f1_idx2:
            jmp rotor_finishizat_f1
        rotor_finishizat_f1:
        jmp finish
    finish:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

; void enigma(char *plain, char key[3], char notches[3], char config[10][26], char *enc);
enigma:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; plain (address of first_time element in string)
    mov ebx, [ebp + 12] ; key
    mov ecx, [ebp + 16] ; notches
    mov edx, [ebp + 20] ; config (address of first_time element in matrix)
    mov edi, [ebp + 24] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement enigma
    ;; FREESTYLE STARTS HERE

    mov esi, eax
    xor eax, eax
    encode:
        cmp eax, [len_plain]
        je finish_encode
        push eax
        xor eax, eax
        mov al, byte [ecx + 1]
        cmp byte [ebx + 1], al
        je move_rotor0
        xor eax, eax
        mov al, byte [ecx + 2]
        cmp byte [ebx + 2], al
        jne NO_move_rotor1
        je move_rotor1
        move_rotor0:
            push dword [ZERO]
            push edx
            push dword [ZERO]
            push dword [UNO]
            call rotate_x_positions
            add esp, 16
        move_pos0:
            inc byte [ebx]
            cmp byte [ebx], 'Z'
            jle pos0_in_alphabet
            sub byte [ebx], LETTERS_COUNT
            pos0_in_alphabet:
        NO_move_rotor0:
        move_rotor1:
            push dword [ZERO]
            push edx
            push dword [UNO]
            push dword [UNO]
            call rotate_x_positions
            add esp, 16
        move_pos1:
            inc byte [ebx + 1]
            cmp byte [ebx + 1], 'Z'
            jle pos1_in_alphabet
            sub byte [ebx + 1], LETTERS_COUNT
            pos1_in_alphabet:
        NO_move_rotor1:
        move_rotor2:
            push dword [ZERO]
            push edx
            push dword [DOI]
            push dword [UNO]
            call rotate_x_positions
            add esp, 16
        move_pos2:
            inc byte [ebx + 2]
            cmp byte [ebx + 2], 'Z'
            jle pos2_in_alphabet
            sub byte [ebx + 2], LETTERS_COUNT
            pos2_in_alphabet:
        pop eax
        push ebx
        push ecx
        xor ebx, ebx
        mov bl, byte [esi + eax]
        xor ecx, ecx
        parse_playboard_first_time:
            cmp byte [edx + 9*LETTERS_COUNT + ecx], bl
            je finish_parse_playboard_first_time
            inc ecx
            jmp parse_playboard_first_time
        finish_parse_playboard_first_time:
        xor ebx, ebx
        mov bl, byte [edx + 5*LETTERS_COUNT + ecx]
        xor ecx, ecx
        parse_rotor2_first_time:
            cmp byte [edx + 4*LETTERS_COUNT + ecx], bl
            je finish_parse_rotor2_first_time
            inc ecx
            jmp parse_rotor2_first_time
        finish_parse_rotor2_first_time:
        xor ebx, ebx
        mov bl, byte [edx + 3*LETTERS_COUNT + ecx]
        xor ecx, ecx
        parse_rotor1_first_time:
            cmp byte [edx + 2*LETTERS_COUNT + ecx], bl
            je finish_parse_rotor1_first_time
            inc ecx
            jmp parse_rotor1_first_time
        finish_parse_rotor1_first_time:
        xor ebx, ebx
        mov bl, byte [edx + LETTERS_COUNT + ecx]
        xor ecx, ecx
        parse_rotor0_first_time:
            cmp byte [edx + ecx], bl
            je finish_parse_rotor0_first_time
            inc ecx
            jmp parse_rotor0_first_time
        finish_parse_rotor0_first_time:
        xor ebx, ebx
        mov bl, byte [edx + 7*LETTERS_COUNT + ecx]
        xor ecx, ecx
        parse_reflector:
            cmp byte [edx + 6*LETTERS_COUNT + ecx], bl
            je finish_parse_reflector
            inc ecx
            jmp parse_reflector
        finish_parse_reflector:
        xor ebx, ebx
        mov bl, byte [edx + ecx]
        xor ecx, ecx
        parse_rotor0_second_time:
            cmp byte [edx + LETTERS_COUNT + ecx], bl
            je finish_parse_rotor0_second_time
            inc ecx
            jmp parse_rotor0_second_time
        finish_parse_rotor0_second_time:
        xor ebx, ebx
        mov bl, byte [edx + 2*LETTERS_COUNT + ecx]
        xor ecx, ecx
        parse_rotor1_second_time:
            cmp byte [edx + 3*LETTERS_COUNT + ecx], bl
            je finish_parse_rotor1_second_time
            inc ecx
            jmp parse_rotor1_second_time
        finish_parse_rotor1_second_time:
        xor ebx, ebx
        mov bl, byte [edx + 4*LETTERS_COUNT + ecx]
        xor ecx, ecx
        parse_rotor2_second_time:
            cmp byte [edx + 5*LETTERS_COUNT + ecx], bl
            je finish_parse_rotor2_second_time
            inc ecx
            jmp parse_rotor2_second_time
        finish_parse_rotor2_second_time:
        xor ebx, ebx
        mov bl, byte [edx + 9*LETTERS_COUNT + ecx]
        xor ecx, ecx
        parse_playboard_second_time:
            cmp byte [edx + 8*LETTERS_COUNT + ecx], bl
            je finish_parse_playboard_second_time
            inc ecx
            jmp parse_playboard_second_time
        finish_parse_playboard_second_time:
        xor ebx, ebx
        mov bl, byte [edx + 8*LETTERS_COUNT + ecx]
        mov byte [edi + eax], bl
        pop ecx
        pop ebx
        inc eax
        jmp encode
    finish_encode:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY