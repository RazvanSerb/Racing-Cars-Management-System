extern array_idx_1      ;; int array_idx_1

section .text
    global inorder_parc

;   struct node {
;       int value;
;       struct node *left;
;       struct node *right;
;   } __attribute__((packed));

;;  inorder_parc(struct node *node, int *array);
;       functia va parcurge in inordine arborele binar de cautare, salvand
;       valorile nodurilor in vectorul array.
;    @params:
;        node  -> nodul actual din arborele de cautare;
;        array -> adresa vectorului unde se vor salva valorile din noduri;

; ATENTIE: vectorul array este INDEXAT DE LA 0!
;          Cititi SI fisierul README.md din cadrul directorului pentru exemple,
;          explicatii mai detaliate!
; HINT: folositi variabila importata array_idx_1 pentru a retine pozitia
;       urmatorului element ce va fi salvat in vectorul array.
;       Este garantat ca aceasta variabila va fi setata pe 0 la fiecare
;       test.

inorder_parc:
    enter 0, 0
    pusha

    mov esi, [ebp + 8]             ; esi - nodul actual din arborele de cautare
    mov edi, [ebp + 12]            ; edi - adresa vectorului unde se vor salva valorile din noduri

condition_finish:
    cmp esi, 0
    je finish
left:
    push edi                       ; pun pe stiva al doilea parametru pentru inorder_parc
    push dword [esi + 4]           ; pun pe stiva primul parametru pentru inorder_parc
    call inorder_parc              ; apel recursiv
    pop dword [esi + 4]            ; scot de pe stiva primul parametru pentru inorder_parc
    pop edi                        ; scot de pe stiva al doilea parametru pentru inorder_parc
root:
    mov ebx, dword [esi]           ; ebx - valoarea nodului de la adresa din esi
    mov ecx, dword [array_idx_1]   ; ecx - pozitia unde s-a ajuns in vectorul de output
    mov dword [edi + 4 * ecx], ebx ; punera efectiva in vectorul de output a valorii
    add dword [array_idx_1], 1     ; marirea pozitiei unde s-a ajuns in vectorul de output
right:
    push edi                       ; pun pe stiva al doilea parametru pentru inorder_parc
    push dword [esi + 8]           ; pun pe stiva primul parametru pentru inorder_parc
    call inorder_parc              ; apel recursiv
    pop dword [esi + 8]            ; scot de pe stiva primul parametru pentru inorder_parc
    pop edi                        ; scot de pe stiva al doilea parametru pentru inorder_parc

finish:
    popa
    leave
    ret
