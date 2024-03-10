section .data
	; declare global vars here
	quadruplet dd 0
	letter dd 0

section .text
	global reverse_vowels

;; void reverse_vowels(char *string)
; Cauta toate vocalele din sirul `string` si afiseaza-le
; in ordine inversa. Consoanele raman nemodificate.
; Modificare se va face in-place
reverse_vowels:
	push ebp
	push esp
	pop ebp
	pusha

	push dword [ebp + 8]           ; pun pe stiva adresa de inceput a sirului
	pop esi                        ; esi - adresa de inceput a sirului

	xor ecx, ecx                   ; ecx - contor pentru a parcurge caracterele din 4 in 4
parse_vector_p1:
	push dword [esi + 4 * ecx]     ; pun pe stiva cate un quadruplet de caractere
	pop dword [quadruplet]         ; quadruplet - valoarea celor 4 caractere
p1_character1:
	push dword [quadruplet]        ; pun pe stiva valoarea quadruplet-ului
	pop dword [letter]			   ; letter - copie a quadruplet-ului
	and dword [letter], 255
	push dword [letter]
	pop eax
	cmp al, 0                      ; verific daca primul caracter din cele 4 extrase e NULL
	je finish_parse_vector_p1
	cmp al, 'a'
	je p1_character1_vowel
	cmp al, 'e'
	je p1_character1_vowel
	cmp al, 'i'
	je p1_character1_vowel
	cmp al, 'o'
	je p1_character1_vowel
	cmp al, 'u'
	je p1_character1_vowel
	jmp p1_character2
p1_character1_vowel:
	push eax					   ; pun pe stiva vocala gasita
p1_character2:
	push dword [quadruplet]        ; pun pe stiva valoarea quadruplet-ului
	pop dword [letter]			   ; letter - copie a quadruplet-ului
	shr dword [letter], 8
	and dword [letter], 255
	push dword [letter]
	pop eax
	cmp al, 0                      ; verific daca al doilea caracter din cele 4 extrase e NULL
	je finish_parse_vector_p1
	cmp al, 'a'
	je p1_character2_vowel
	cmp al, 'e'
	je p1_character2_vowel
	cmp al, 'i'
	je p1_character2_vowel
	cmp al, 'o'
	je p1_character2_vowel
	cmp al, 'u'
	je p1_character2_vowel
	jmp p1_character3
p1_character2_vowel:
	push eax					   ; pun pe stiva vocala gasita
p1_character3:
	push dword [quadruplet]        ; pun pe stiva valoarea quadruplet-ului
	pop dword [letter]			   ; letter - copie a quadruplet-ului
	shr dword [letter], 16
	and dword [letter], 255
	push dword [letter]
	pop eax
	cmp al, 0                      ; verific daca al treilea caracter din cele 4 extrase e NULL
	je finish_parse_vector_p1
	cmp al, 'a'
	je p1_character3_vowel
	cmp al, 'e'
	je p1_character3_vowel
	cmp al, 'i'
	je p1_character3_vowel
	cmp al, 'o'
	je p1_character3_vowel
	cmp al, 'u'
	je p1_character3_vowel
	jmp p1_character4
p1_character3_vowel:
	push eax					   ; pun pe stiva vocala gasita
p1_character4:
	push dword [quadruplet]        ; pun pe stiva valoarea quadruplet-ului
	pop dword [letter]			   ; letter - copie a quadruplet-ului
	shr dword [letter], 24
	and dword [letter], 255
	push dword [letter]
	pop eax
	cmp al, 0                      ; verific daca al patrulea caracter din cele 4 extrase e NULL
	je finish_parse_vector_p1
	cmp al, 'a'
	je p1_character4_vowel
	cmp al, 'e'
	je p1_character4_vowel
	cmp al, 'i'
	je p1_character4_vowel
	cmp al, 'o'
	je p1_character4_vowel
	cmp al, 'u'
	je p1_character4_vowel
	jmp p1_next_quadruplet
p1_character4_vowel:
	push eax					   ; pun pe stiva vocala gasita
p1_next_quadruplet:
	inc ecx                        ; trec la urmatorul quadruplet de caractere
	jmp parse_vector_p1
finish_parse_vector_p1:

	xor ecx, ecx
parse_vector_p2:
	push dword [esi + 4 * ecx]     ; pun pe stiva cate un quadruplet de charactere
	pop dword [quadruplet]         ; quadruplet - valoarea celor 4 charactere
p2_character1:
	push dword [quadruplet]        ; pun pe stiva valoarea quadruplet-ului
	pop dword [letter]			   ; letter - copie a quadruplet-ului
	and dword [letter], 255
	push dword [letter]
	pop eax
	cmp al, 0                      ; verific daca primul caracter din cele 4 extrase e NULL
	je finish_parse_vector_p2
	cmp al, 'a'
	je p2_character1_vowel
	cmp al, 'e'
	je p2_character1_vowel
	cmp al, 'i'
	je p2_character1_vowel
	cmp al, 'o'
	je p2_character1_vowel
	cmp al, 'u'
	je p2_character1_vowel
	jmp p2_character2
p2_character1_vowel:
	pop ebx						   ; ebx - ultima vocala de pe stiva pe byte-ul 1 nesemnificativ
	push dword [quadruplet]
	pop edx						   ; edx - quadruplet-ul actual
	and edx, 4294967040			   ; se pune 0 pe byte-ul 1 nesemnificativ
	or edx, ebx					   ; se pune noua vocala pe byte-ul 1 nesemnificativ
	push edx
	pop dword [esi + 4 * ecx]      ; se modifica quadruplet-ul vechi
	push edx
	pop dword [quadruplet]         ; se modifica quadruplet-ul vechi
p2_character2:
	push dword [quadruplet]        ; pun pe stiva valoarea quadruplet-ului
	pop dword [letter]			   ; letter - copie a quadruplet-ului
	shr dword [letter], 8
	and dword [letter], 255
	push dword [letter]
	pop eax
	cmp al, 0                      ; verific daca al doilea caracter din cele 4 extrase e NULL
	je finish_parse_vector_p2
	cmp al, 'a'
	je p2_character2_vowel
	cmp al, 'e'
	je p2_character2_vowel
	cmp al, 'i'
	je p2_character2_vowel
	cmp al, 'o'
	je p2_character2_vowel
	cmp al, 'u'
	je p2_character2_vowel
	jmp p2_character3
p2_character2_vowel:
	pop ebx						   ; ebx - ultima vocala de pe stiva pe byte-ul 2 nesemnificativ
	shl ebx, 8
	push dword [quadruplet]
	pop edx						   ; edx - quadruplet-ul actual
	and edx, 4294902015			   ; se pune 0 pe byte-ul 2 nesemnificativ
	or edx, ebx					   ; se pune noua vocala pe byte-ul 2 nesemnificativ
	push edx
	pop dword [esi + 4 * ecx]      ; se modifica quadruplet-ul vechi
	push edx
	pop dword [quadruplet]         ; se modifica quadruplet-ul vechi
p2_character3:
	push dword [quadruplet]        ; pun pe stiva valoarea quadruplet-ului
	pop dword [letter]			   ; letter - copie a quadruplet-ului
	shr dword [letter], 16
	and dword [letter], 255
	push dword [letter]
	pop eax
	cmp al, 0                      ; verific daca al treilea caracter din cele 4 extrase e NULL
	je finish_parse_vector_p2
	cmp al, 'a'
	je p2_character3_vowel
	cmp al, 'e'
	je p2_character3_vowel
	cmp al, 'i'
	je p2_character3_vowel
	cmp al, 'o'
	je p2_character3_vowel
	cmp al, 'u'
	je p2_character3_vowel
	jmp p2_character4
p2_character3_vowel:
	pop ebx						   ; ebx - ultima vocala de pe stiva pe byte-ul 3 nesemnificativ
	shl ebx, 16
	push dword [quadruplet]
	pop edx						   ; edx - quadruplet-ul actual
	and edx, 4278255615			   ; se pune 0 pe byte-ul 3 nesemnificativ
	or edx, ebx					   ; se pune noua vocala pe byte-ul 3 nesemnificativ
	push edx
	pop dword [esi + 4 * ecx]      ; se modifica quadruplet-ul vechi
	push edx
	pop dword [quadruplet]         ; se modifica quadruplet-ul vechi
p2_character4:
	push dword [quadruplet]        ; pun pe stiva valoarea quadruplet-ului
	pop dword [letter]			   ; letter - copie a quadruplet-ului
	shr dword [letter], 24
	and dword [letter], 255
	push dword [letter]
	pop eax
	cmp al, 0                      ; verific daca al patrulea caracter din cele 4 extrase e NULL
	je finish_parse_vector_p2
	cmp al, 'a'
	je p2_character4_vowel
	cmp al, 'e'
	je p2_character4_vowel
	cmp al, 'i'
	je p2_character4_vowel
	cmp al, 'o'
	je p2_character4_vowel
	cmp al, 'u'
	je p2_character4_vowel
	jmp p2_next_quadruplet
p2_character4_vowel:
	pop ebx						   ; ebx - ultima vocala de pe stiva pe byte-ul 4 nesemnificativ
	shl ebx, 24
	push dword [quadruplet]
	pop edx						   ; edx - quadruplet-ul actual
	and edx, 16777215			   ; se pune 0 pe byte-ul 4 nesemnificativ
	or edx, ebx					   ; se pune noua vocala pe byte-ul 4 nesemnificativ
	push edx
	pop dword [esi + 4 * ecx]      ; se modifica quadruplet-ul vechi
	push edx
	pop dword [quadruplet]         ; se modifica quadruplet-ul vechi
p2_next_quadruplet:
	inc ecx                        ; trec la urmatorul quadruplet de charactere
	jmp parse_vector_p2
finish_parse_vector_p2:
	
	popa
	pop ebp
	ret