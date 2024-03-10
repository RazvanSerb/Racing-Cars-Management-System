section .text
    global inorder_fixing

;   struct node {
;       int value;
;       struct node *left;
;       struct node *right;
;   } __attribute__((packed));

;;  inorder_fixing(struct node *node, struct node *parent)
;       functia va parcurge in inordine arborele binar de cautare, modificand
;       valorile nodurilor care NO respecta proprietatea de arbore binar
;       de cautare: |node->value > node->left->value, daca node->left exista
;                   |node->value < node->right->value, daca node->right exista.
;
;       Unde este nevoie de modificari se va aplica algoritmul:
;           - daca nodul actual este fiul stang, va primi valoare tatalui - 1,
;                altfel spus: node->value = parent->value - 1;
;           - daca nodul actual este fiul drept, va primi valoare tatalui + 1,
;                altfel spus: node->value = parent->value + 1;

;    @params:
;        node   -> nodul actual din arborele de cautare;
;        parent -> tatal/parintele nodului actual din arborele de cautare;

; ATENTIE: DOAR in frunze pot aparea valori gresite! 
;          Cititi SI fisierul README.md din cadrul directorului pentru exemple,
;          explicatii mai detaliate!

inorder_fixing:
    enter 0, 0
    pusha

    mov esi, [ebp + 8]             ; esi - nodul actual din arborele de cautare
    mov eax, [ebp + 12]            ; eax - tatal nodului actual din arborele de cautare

condition_finish:
    cmp esi, 0
    je finish
left:
    push dword [esi]               ; pun pe stiva al doilea parametru pentru inorder_fixing
    push dword [esi + 4]           ; pun pe stiva primul parametru pentru inorder_fixing
    call inorder_fixing            ; apel recursiv
    pop dword [esi + 4]            ; scot de pe stiva primul parametru pentru inorder_fixing
    pop dword [esi]                ; scot de pe stiva al doilea parametru pentru inorder_fixing
root:
son_left:
    cmp dword [esi + 4], 0         ; verific daca exista fiu stang
    je NO_son_left
    mov ebx, esi                   
    mov ebx, dword [esi + 4]
    mov ebx, dword [ebx]           ; ebx - valoarea fiului stang
    cmp dword [esi], ebx           ; conditia de arbore binar de cautare
    jg NO_modify_son_left
    mov ebx, dword [esi + 4]
    mov edx, dword [esi]
    dec edx
    mov dword [ebx], edx
    mov dword [esi + 4], ebx       ; modific valoarea conform cerintei
    NO_son_left:
    NO_modify_son_left:
son_right:
    cmp dword [esi + 8], 0         ; verific daca exista fiu drept
    je NO_son_right
    mov ebx, esi
    mov ebx, dword [esi + 8]
    mov ebx, dword [ebx]           ; ebx - valoarea fiului drept
    cmp dword [esi], ebx           ; conditia de arbore binar de cautare
    jl NO_modify_son_right
    mov ebx, dword [esi + 8]
    mov edx, dword [esi]
    inc edx
    mov dword [ebx], edx
    mov dword [esi + 8], ebx       ; modific valoarea conform cerintei
    NO_son_right:
    NO_modify_son_right:
right:
    push dword [esi]               ; pun pe stiva al doilea parametru pentru inorder_fixing
    push dword [esi + 8]           ; pun pe stiva primul parametru pentru inorder_fixing
    call inorder_fixing            ; apel recursiv
    pop dword [esi + 8]            ; scot de pe stiva primul parametru pentru inorder_fixing
    pop dword [esi]                ; scot de pe stiva al doilea parametru pentru inorder_fixing

finish:
    popa
    leave
    ret
