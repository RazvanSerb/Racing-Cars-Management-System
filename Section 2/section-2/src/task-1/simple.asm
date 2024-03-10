%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here

    xor ebx, ebx                ; initializare contor pentru for-ul "parse_vector"
parse_vector:
    xor eax, eax                ; initializare eax cu valoarea "0"
    mov eax, [esi + ebx]        ; pun valoarea caracterului de pe pozitia "ebx" in registrul "eax"
    add eax, edx                ; adaug valoarea step-ului la valoarea caracterului 
    mov ah, 'Z'                 ; pun valoarea caracterului "Z" in subregistrul "ah"
    cmp al, ah                  ; compar caracterul obtinut prin adaugarea step-ului cu "Z"
    jle char_in_alphabet
    jg char_out_alphabet
    char_in_alphabet:
        xor ah, ah              ; inlocuiesc valoarea caracterului "Z" cu "0" in subregistrul "ah"
        mov [edi + ebx], eax    ; pun valoarea caracterului nou obtinut in sirul final
        inc ebx                 ; actualizare contor pentru for-ul "parse_vector"
        cmp ebx, ecx            ; conditie finish pentru for-ul "parse_vector"
        jne parse_vector
        jmp finish
    char_out_alphabet:
        xor ah, ah              ; inlocuiesc valoarea caracterului "Z" cu "0" in subregistrul "ah"
        sub eax, 26             ; fac rotatie pentru caracterul nou obtinut care necesita
        mov [edi + ebx], eax    ; pun valoarea caracterului nou obtinut in sirul final
        inc ebx                 ; actualizare contor pentru for-ul "parse_vector"
        cmp ebx, ecx            ; conditie finish pentru for-ul "parse_vector"
        jne parse_vector
        jmp finish
finish:

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
