global get_words
global compare_func
global sort

section .text
    extern strlen
    extern strcmp
    extern qsort
    extern strtok

section .data
    return_value dd 0
    delimitators db " ,.", 10, 0

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografic
compare_func:
    enter 0, 0
    pusha

    mov esi, [ebp + 8]             ; esi - pointer la un string "a" 
    mov edi, [ebp + 12]            ; edi - pointer la un string "b"
    mov esi, [esi]                 ; esi - valoarea unui string "a"
    mov edi, [edi]                 ; edi - valoarea unui string "b"

    mov dword [return_value], -1  ; pun in variabila valoarea -1 sa semnalizez ca nu interschimb
    xor eax, eax
    xor ebx, ebx
    push esi
    call strlen
    pop esi
    mov ebx, eax                   ; ebx - lungimea stringului "a"
    xor eax, eax
    xor ecx, ecx
    push edi
    call strlen
    pop edi
    mov ecx, eax                   ; ecx - lungimea stringului "b"
    cmp ebx, ecx                   ; compar dupa lungime
    je compare_lexicographic
    jl exit
    jg swap
swap:
    mov dword [return_value], 1   ; pun in variabila valoarea 1 sa semnalizez ca interschimb
    jmp exit
compare_lexicographic:
    push edi
    push esi
    call strcmp                    ; compar lexicografic
    pop esi
    pop edi
    mov dword [return_value], eax ; pun in variabila rezultatul lui "strcmp" (-1 / 1)
    jmp exit
    
exit:
    popa
    mov eax, dword [return_value] ; pun variabila in eax pentru a putea returna valoarea ei
    leave
    ret

sort:
    enter 0, 0
    pusha

    mov esi, [ebp + 8]             ; esi - vectorul de cuvinte "words"
    mov ecx, [ebp + 12]            ; ecx - numarul de cuvinte
    mov ebx, [ebp + 16]            ; ebx - dimensiunea unui cuvant

    push compare_func
    push ebx
    push ecx
    push esi
    call qsort                     ; apelez qsort
    pop esi
    pop ecx
    pop ebx
    pop edx

    popa
    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
 
get_words:
    enter 0, 0
    pusha

    mov esi, [ebp + 8]             ; esi - string-ul initial
    mov edi, [ebp + 12]            ; edi - vectorul "words" unde se vor pune cuvintele
    mov ecx, [ebp + 16]            ; ecx - numarul de cuvinte

initialize_string_strtok:
    push delimitators
    push esi
    call strtok                    ; apelez strtok cu adresa string-ului initial
    pop edx
    pop edx
extract_words:
    mov [edi], eax                 ; adaug cuvantul actual in vectorul de cuvinte "words"
    add edi, 4
    push delimitators
    push 0
    call strtok                    ; apelez strtok cu NULL
    pop edx
    pop edx
    cmp eax, 0
    je finish
    jne extract_words

finish:
    popa
    leave
    ret
