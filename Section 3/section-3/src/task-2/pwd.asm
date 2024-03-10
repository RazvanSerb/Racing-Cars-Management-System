section .data
	back db "..", 0
	curr db ".", 0
	slash db "/", 0
	; declare global vars here

section .text
	global pwd

;; void pwd(char **directories, int n, char *output)
; Adauga in parametrul output path-ul rezultat din
; parsea celor n foldere din directories
pwd:
	enter 0, 0
	pusha

	mov esi, [ebp + 8]             ; esi - adresa vectorului de string-uri "directories"
	mov edx, [ebp + 12]            ; edx - numarul de directories (n)
	mov edi, [ebp + 16]            ; edi - adresa unde se pune rezultatul

	xor eax, eax				   ; eax - contor pentru parsea fiecarui string
	xor ebx, ebx                   ; ebx - contor pentru ce e scris in vectorul "output"
	xor ecx, ecx
	mov cl, byte [slash]
	mov byte [edi + ebx], cl       ; adaug "slash" in vectorul "output"
	inc ebx
	xor ecx, ecx                   ; ecx - contor pentru "parse_directories"
parse_directories:
	push ecx
	push esi
	mov esi, [esi]
	xor ecx, ecx
	mov cl, byte [curr]
	cmp byte [esi + eax], cl
	jne parse_name_director
	xor ecx, ecx
	mov cl, byte [back]
	cmp byte [esi + eax + 1], cl
	jne next_director
	je go_to_previous_director
	go_to_previous_director:
		cmp ebx, 1
		je next_director
		eliminate_director_current:
			dec ebx
			mov byte [edi + ebx], 0
			xor ecx, ecx
			mov cl, byte [slash]
			cmp byte [edi + ebx - 1], cl
			jne eliminate_director_current
		mov byte [edi + ebx], 0
		jmp next_director
	parse_name_director:
		xor ecx, ecx
		mov cl, byte [esi + eax]
		inc eax
		cmp cl, 0
		je put_slash
		mov byte [edi + ebx], cl
		inc ebx
		jmp parse_name_director
	put_slash:
		xor ecx, ecx
		mov cl, byte [slash]
		mov byte [edi + ebx], cl
		inc ebx
		xor eax, eax
	next_director:
	pop esi
	add esi, 4
	pop ecx
	inc ecx
	cmp ecx, edx
	jl parse_directories

	popa
	leave
	ret