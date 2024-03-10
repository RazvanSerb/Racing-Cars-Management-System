section .data
    value_board_0 dd 0
    value_board_1 dd 0

section .text
    global bonus

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    mov dword [value_board_0], 0
    mov dword [value_board_1], 0

positions_of_checker:
NORTH_WEST:
    mov ah, 7
    cmp al, ah
    je invalid_NORTH_WEST
    mov bh, 0
    cmp bl, bh
    je invalid_NORTH_WEST
    xor ah, ah
    xor bh, bh
    inc eax
    dec ebx
    ; (x+1, y-1)
    xor esi, esi
    xor edi, edi
    mov ah, 4
    cmp al, ah
    jge board_0_NORTH_WEST
    jl board_1_NORTH_WEST
    board_0_NORTH_WEST:
        xor ah, ah
        mov dword [ecx], 1
        mov esi, eax
        sub esi, 4
        cmp esi, 0
        je repect_coordinate_x_board_0_NORTH_WEST
        move_checker_to_x_board_0_NORTH_WEST:
            shl dword [ecx], 8
            sub esi, 1
            jnz move_checker_to_x_board_0_NORTH_WEST
        repect_coordinate_x_board_0_NORTH_WEST:
        mov edi, ebx
        cmp edi, 0
        je repect_coordinate_y_board_0_NORTH_WEST
        move_checker_to_y_board_0_NORTH_WEST:
            shl dword [ecx], 1
            sub edi, 1
            jnz move_checker_to_y_board_0_NORTH_WEST
        repect_coordinate_y_board_0_NORTH_WEST:
        xor ah, ah
        dec eax
        inc ebx
        jmp invalid_NORTH_WEST
    board_1_NORTH_WEST:
        xor ah, ah
        mov dword [ecx + 4], 1
        mov esi, eax
        cmp esi, 0
        je repect_coordinate_x_board_1_NORTH_WEST
        move_checker_to_x_board_1_NORTH_WEST:
            shl dword [ecx + 4], 8
            sub esi, 1
            jnz move_checker_to_x_board_1_NORTH_WEST
        repect_coordinate_x_board_1_NORTH_WEST:
        mov edi, ebx
        cmp edi, 0
        je repect_coordinate_y_board_1_NORTH_WEST
        move_checker_to_y_board_1_NORTH_WEST:
            shl dword [ecx + 4], 1
            sub edi, 1
            jnz move_checker_to_y_board_1_NORTH_WEST
        repect_coordinate_y_board_1_NORTH_WEST:
        xor ah, ah
        dec eax
        inc ebx
        jmp invalid_NORTH_WEST
invalid_NORTH_WEST:
    mov edx, [value_board_0]
    or edx, [ecx]
    mov [value_board_0], edx
    mov edx, [value_board_1]
    or edx, [ecx + 4]
    mov [value_board_1], edx
NORTH_EST:
    mov ah, 7
    cmp al, ah
    je invalid_NORTH_EST
    mov bh, 7
    cmp bl, bh
    je invalid_NORTH_EST
    xor ah, ah
    xor bh, bh
    inc eax
    inc ebx
    ; (x+1, y+1)
    xor esi, esi
    xor edi, edi
    mov ah, 4
    cmp al, ah
    jge board_0_NORTH_EST
    jl board_1_NORTH_EST
    board_0_NORTH_EST:
        xor ah, ah
        mov dword [ecx], 1
        mov esi, eax
        sub esi, 4
        cmp esi, 0
        je repect_coordinate_x_board_0_NORTH_EST
        move_checker_to_x_board_0_NORTH_EST:
            shl dword [ecx], 8
            sub esi, 1
            jnz move_checker_to_x_board_0_NORTH_EST
        repect_coordinate_x_board_0_NORTH_EST:
        mov edi, ebx
        cmp edi, 0
        je repect_coordinate_y_board_0_NORTH_EST
        move_checker_to_y_board_0_NORTH_EST:
            shl dword [ecx], 1
            sub edi, 1
            jnz move_checker_to_y_board_0_NORTH_EST
        repect_coordinate_y_board_0_NORTH_EST:
        xor ah, ah
        dec eax
        dec ebx
        jmp invalid_NORTH_EST
    board_1_NORTH_EST:
        xor ah, ah
        mov dword [ecx + 4], 1
        mov esi, eax
        cmp esi, 0
        je repect_coordinate_x_board_1_NORTH_EST
        move_checker_to_x_board_1_NORTH_EST:
            shl dword [ecx + 4], 8
            sub esi, 1
            jnz move_checker_to_x_board_1_NORTH_EST
        repect_coordinate_x_board_1_NORTH_EST:
        mov edi, ebx
        cmp edi, 0
        je repect_coordinate_y_board_1_NORTH_EST
        move_checker_to_y_board_1_NORTH_EST:
            shl dword [ecx + 4], 1
            sub edi, 1
            jnz move_checker_to_y_board_1_NORTH_EST
        repect_coordinate_y_board_1_NORTH_EST:
        xor ah, ah
        dec eax
        dec ebx
        jmp invalid_NORTH_EST
invalid_NORTH_EST:
    mov edx, [value_board_0]
    or edx, [ecx]
    mov [value_board_0], edx
    mov edx, [value_board_1]
    or edx, [ecx + 4]
    mov [value_board_1], edx
SOUTH_EST:
    mov ah, 0
    cmp al, ah
    je invalid_SOUTH_EST
    mov bh, 7
    cmp bl, bh
    je invalid_SOUTH_EST
    xor ah, ah
    xor bh, bh
    dec eax
    inc ebx
    ; (x-1, y+1)
    xor esi, esi
    xor edi, edi
    mov ah, 4
    cmp al, ah
    jge board_0_SOUTH_EST
    jl board_1_SOUTH_EST
    board_0_SOUTH_EST:
        xor ah, ah
        mov dword [ecx], 1
        mov esi, eax
        sub esi, 4
        cmp esi, 0
        je repect_coordinate_x_board_0_SOUTH_EST
        move_checker_to_x_board_0_SOUTH_EST:
            shl dword [ecx], 8
            sub esi, 1
            jnz move_checker_to_x_board_0_SOUTH_EST
        repect_coordinate_x_board_0_SOUTH_EST:
        mov edi, ebx
        cmp edi, 0
        je repect_coordinate_y_board_0_SOUTH_EST
        move_checker_to_y_board_0_SOUTH_EST:
            shl dword [ecx], 1
            sub edi, 1
            jnz move_checker_to_y_board_0_SOUTH_EST
        repect_coordinate_y_board_0_SOUTH_EST:
        xor ah, ah
        inc eax
        dec ebx
        jmp invalid_SOUTH_EST
    board_1_SOUTH_EST:
        xor ah, ah
        mov dword [ecx + 4], 1
        mov esi, eax
        cmp esi, 0
        je repect_coordinate_x_board_1_SOUTH_EST
        move_checker_to_x_board_1_SOUTH_EST:
            shl dword [ecx + 4], 8
            sub esi, 1
            jnz move_checker_to_x_board_1_SOUTH_EST
        repect_coordinate_x_board_1_SOUTH_EST:
        mov edi, ebx
        cmp edi, 0
        je repect_coordinate_y_board_1_SOUTH_EST
        move_checker_to_y_board_1_SOUTH_EST:
            shl dword [ecx + 4], 1
            sub edi, 1
            jnz move_checker_to_y_board_1_SOUTH_EST
        repect_coordinate_y_board_1_SOUTH_EST:
        xor ah, ah
        inc eax
        dec ebx
        jmp invalid_SOUTH_EST
invalid_SOUTH_EST:
    mov edx, [value_board_0]
    or edx, [ecx]
    mov [value_board_0], edx
    mov edx, [value_board_1]
    or edx, [ecx + 4]
    mov [value_board_1], edx
SOUTH_WEST:
    mov ah, 0
    cmp al, ah
    je invalid_SOUTH_WEST
    mov bh, 0
    cmp bl, bh
    je invalid_SOUTH_WEST
    xor ah, ah
    xor bh, bh
    dec eax
    dec ebx
    ; (x-1, y-1)
    xor esi, esi
    xor edi, edi
    mov ah, 4
    cmp al, ah
    jge board_0_SOUTH_WEST
    jl board_1_SOUTH_WEST
    board_0_SOUTH_WEST:
        xor ah, ah
        mov dword [ecx], 1
        mov esi, eax
        sub esi, 4
        cmp esi, 0
        je repect_coordinate_x_board_0_SOUTH_WEST
        move_checker_to_x_board_0_SOUTH_WEST:
            shl dword [ecx], 8
            sub esi, 1
            jnz move_checker_to_x_board_0_SOUTH_WEST
        repect_coordinate_x_board_0_SOUTH_WEST:
        mov edi, ebx
        cmp edi, 0
        je repect_coordinate_y_board_0_SOUTH_WEST
        move_checker_to_y_board_0_SOUTH_WEST:
            shl dword [ecx], 1
            sub edi, 1
            jnz move_checker_to_y_board_0_SOUTH_WEST
        repect_coordinate_y_board_0_SOUTH_WEST:
        xor ah, ah
        inc eax
        inc ebx
        jmp invalid_SOUTH_WEST
    board_1_SOUTH_WEST:
        xor ah, ah
        mov dword [ecx + 4], 1
        mov esi, eax
        cmp esi, 0
        je repect_coordinate_x_board_1_SOUTH_WEST
        move_checker_to_x_board_1_SOUTH_WEST:
            shl dword [ecx + 4], 8
            sub esi, 1
            jnz move_checker_to_x_board_1_SOUTH_WEST
        repect_coordinate_x_board_1_SOUTH_WEST:
        mov edi, ebx
        cmp edi, 0
        je repect_coordinate_y_board_1_SOUTH_WEST
        move_checker_to_y_board_1_SOUTH_WEST:
            shl dword [ecx + 4], 1
            sub edi, 1
            jnz move_checker_to_y_board_1_SOUTH_WEST
        repect_coordinate_y_board_1_SOUTH_WEST:
        xor ah, ah
        inc eax
        inc ebx
        jmp invalid_SOUTH_WEST
invalid_SOUTH_WEST:
    mov edx, [value_board_0]
    or edx, [ecx]
    mov [value_board_0], edx
    mov edx, [value_board_1]
    or edx, [ecx + 4]
    mov [value_board_1], edx

    mov edx, [value_board_0]
    mov [ecx], edx
    mov edx, [value_board_1]
    mov [ecx + 4], edx
    
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
