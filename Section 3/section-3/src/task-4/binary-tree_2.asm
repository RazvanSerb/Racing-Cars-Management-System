extern array_idx_2      ;; int array_idx_2

section .text
    global inorder_intruders

;   struct node {
;       int value;
;       struct node *left;
;       struct node *right;
;   } __attribute__((packed));

;;  inorder_intruders(struct node *node, struct node *parent, int *array)
;       functia va parcurge in inordine arborele binar de cautare, salvand
;       valorile nodurilor care nu respecta proprietatea de arbore binar
;       de cautare: |node->value > node->left->value, daca node->left exista
;                   |node->value < node->right->value, daca node->right exista
;
;    @params:
;        node   -> nodul actual din arborele de cautare;
;        parent -> tatal/parintele nodului actual din arborele de cautare;
;        array  -> adresa vectorului unde se vor salva valorile din noduri;

; ATENTIE: DOAR in frunze pot aparea valori gresite!
;          vectorul array este INDEXAT DE LA 0!
;          Cititi SI fisierul README.md din cadrul directorului pentru exemple,
;          explicatii mai detaliate!

; HINT: folositi variabila importata array_idx_2 pentru a retine pozitia
;       urmatorului element ce va fi salvat in vectorul array.
;       Este garantat ca aceasta variabila va fi setata pe 0 la fiecare
;       test al functiei inorder_intruders.      

inorder_intruders:
    enter 0, 0
    pusha

    mov esi, [ebp + 8]             ; esi - nodul actual din arborele de cautare
    mov eax, [ebp + 12]            ; eax - tatal nodului actual din arborele de cautare
    mov edi, [ebp + 16]            ; edi - adresa vectorului unde se vor salva valorile din noduri

condition_finish:
    cmp esi, 0
    je finish
left:
    push edi                       ; pun pe stiva al treilea parametru pentru inorder_intruders
    push dword [esi]               ; pun pe stiva al doilea parametru pentru inorder_intruders
    push dword [esi + 4]           ; pun pe stiva primul parametru pentru inorder_intruders
    call inorder_intruders         ; apel recursiv
    pop dword [esi + 4]            ; scot de pe stiva primul parametru pentru inorder_intruders
    pop dword [esi]                ; scot de pe stiva al doilea parametru pentru inorder_intruders
    pop edi                        ; scot de pe stiva al treilea parametru pentru inorder_intruders
root:
son_left:
    cmp dword [esi + 4], 0         ; verific daca exista fiu stang
    je NU_exista_fiu_stang
    mov ebx, esi                   
    mov ebx, dword [esi + 4]
    mov ebx, dword [ebx]           ; ebx - valoarea fiului stang
    cmp dword [esi], ebx           ; conditia de arbore binar de cautare
    jg NU_retin_fiu_stang
    mov ecx, dword [array_idx_2]   ; ecx - pozitia unde s-a ajuns in vectorul de output
    mov dword [edi + 4 * ecx], ebx ; punera efectiva in vectorul de output a valorii
    add dword [array_idx_2], 1     ; marirea pozitiei unde s-a ajuns in vectorul de output
    NU_exista_fiu_stang:
    NU_retin_fiu_stang:
son_right:
    cmp dword [esi + 8], 0         ; verific daca exista fiu drept
    je NU_exista_fiu_drept
    mov ebx, esi
    mov ebx, dword [esi + 8]
    mov ebx, dword [ebx]           ; ebx - valoarea fiului drept
    cmp dword [esi], ebx           ; conditia de arbore binar de cautare
    jl NU_retin_fiu_drept
    mov ecx, dword [array_idx_2]   ; ecx - pozitia unde s-a ajuns in vectorul de output
    mov dword [edi + 4 * ecx], ebx ; punera efectiva in vectorul de output a valorii
    add dword [array_idx_2], 1     ; marirea pozitiei unde s-a ajuns in vectorul de output
    NU_exista_fiu_drept:
    NU_retin_fiu_drept:
right:
    push edi                       ; pun pe stiva al treilea parametru pentru inorder_intruders
    push dword [esi]               ; pun pe stiva al doilea parametru pentru inorder_intruders
    push dword [esi + 8]           ; pun pe stiva primul parametru pentru inorder_intruders
    call inorder_intruders         ; apel recursiv
    pop dword [esi + 8]            ; scot de pe stiva primul parametru pentru inorder_intruders
    pop dword [esi]                ; scot de pe stiva al doilea parametru pentru inorder_intruders
    pop edi                        ; scot de pe stiva al treilea parametru pentru inorder_intruders

finish:
    popa
    leave
    ret
