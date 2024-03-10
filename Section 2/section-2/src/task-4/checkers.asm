section .data

section .text
	global checkers

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    ; deplasarea se face de la stanga la dreapta, de jos in sus
    mov edx, eax              ; initializare contor pentru for-ul "move_checker_to_x"
    cmp edx, 0                ; verific daca trebuie sa fac deplasare pentru a ajunge pe coloana x
    je respect_coordinate_x
move_checker_to_x:
    add ecx, 8                
    sub edx, 1                ; actualizare contor pentru for-ul "move_checker_to_x"
    jnz move_checker_to_x     ; conditie oprire pentru for-ul "move_checker_to_x"
respect_coordinate_x:
move_checker_to_y:
    add ecx, ebx
; in acest moment, ne aflam pe pozitia damei (x, y)
positions_of_checker:
NORTH_WEST:
    mov ah, 7
    cmp al, ah
    je invalid_NORTH_WEST
    mov bh, 0
    cmp bl, bh
    je invalid_NORTH_WEST
    ; (x+1, y-1)
    add ecx, 8
    sub ecx, 1
    mov byte [ecx], 1
    ; revenire la pozitia (x, y)
    add ecx, 1
    sub ecx, 8
invalid_NORTH_WEST:
    xor ah, ah
    xor bh, bh
NORTH_EST:
    mov ah, 7
    cmp al, ah
    je invalid_NORTH_EST
    mov bh, 7
    cmp bl, bh
    je invalid_NORTH_EST
    ; (x+1, y+1)
    add ecx, 8
    add ecx, 1
    mov byte [ecx], 1
    ; revenire la pozitia (x, y)
    sub ecx, 1
    sub ecx, 8
invalid_NORTH_EST:
    xor ah, ah
    xor bh, bh
SOUTH_EST:
    mov ah, 0
    cmp al, ah
    je invalid_SOUTH_EST
    mov bh, 7
    cmp bl, bh
    je invalid_SOUTH_EST
    ; (x-1, y+1)
    sub ecx, 8
    add ecx, 1
    mov byte [ecx], 1
    ; revenire la pozitia (x, y)
    sub ecx, 1
    add ecx, 8
invalid_SOUTH_EST:
    xor ah, ah
    xor bh, bh
SOUTH_WEST:
    mov ah, 0
    cmp al, ah
    je invalid_SOUTH_WEST
    mov bh, 0
    cmp bl, bh
    je invalid_SOUTH_WEST
    ; (x-1, y-1)
    sub ecx, 8
    sub ecx, 1
    mov byte [ecx], 1
    ; revenire la pozitia (x, y)
    add ecx, 1
    add ecx, 8
invalid_SOUTH_WEST:
    xor ah, ah
    xor bh, bh

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY