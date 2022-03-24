getChar macro
    mov ah, 01h
    int 21h
endm

print macro cadena
    mov ah, 09h
    mov dx, offset cadena
    int 21h
endm

limpiar macro len, filaOriginal, filaPlantilla
    LOCAL DO, COMPARE, FIN
    PUSH SI
    PUSH AX
    xor si, si
    DO:
        mov al, [filaPlantilla+si]		;AQUI
        mov filaOriginal[si], al
        jmp COMPARE
    COMPARE:
        inc si 				;AQUI
        cmp si, len 		;AQUI
        jb DO
        jmp FIN
    FIN:
        POP AX
        POP SI
endm


ObtenerTexto macro buffer
	LOCAL CONTINUE, FIN
	PUSH SI
	PUSH AX
	xor si, si
	CONTINUE:
		getChar
		cmp al, 0dh
		je FIN
		mov buffer[si], al
		inc si
		jmp CONTINUE
	FIN:
		mov al, '$'
		mov buffer[si], al
	POP AX
	POP SI
endm

;******************* IMPRIMIR EN CONSOLA Y ARCHIVOS *******************

imprimir macro len, fichaX, fichaO, y, vc, f, ln, enter
	LOCAL DO, VERFN, VERFB, VERFP, VERFQ, VERFR, VERFRI, VERVC, VERFPB, VERFRB, VERFRIB, VERFQB, FIN, COMPARE

	;000b->VACIO 	001b->FX 	100b->FO	010b->P		011b->Q		101b->R
	;1100b fichaPb    1101 fichaRb       1111 fichaRIb     1110 fichaQb
	;print ln
	print y
	PUSH SI
	PUSH AX
	xor si, si
	DO:
		mov al, [f+si] 
		cmp al, 001b
		je VERFB
		cmp al, 100b
		je VERFN
		cmp al, 010b
		je VERFP
		cmp al, 011b
		je VERFQ
		cmp al, 101b
		je VERFR
		cmp al, 110b
		je VERFRI
		cmp al, 1100b
		je VERFPB
		cmp al, 1101b
		je VERFRIB
		cmp al, 1111b
		je VERFRB
		cmp al, 1110b
		je VERFQB
		jmp VERVC
	COMPARE:
		inc si  
		cmp si, len  
		jb DO
		jmp FIN
	VERFB:
		print fichaX
		jmp COMPARE
	VERFN:
		print fichaO
		jmp COMPARE	
	VERFP: 
		mov [f+si], 1100b
		print FichaPb
		jmp COMPARE	
	VERFQ:
		mov [f+si], 1110b	
		print fichaQb	
		jmp COMPARE	
	VERFR:
		mov [f+si], 1111b
		print fichaRb
		jmp COMPARE	
	VERFRI:
		mov [f+si], 1101b
		print fichaRIb
		jmp COMPARE
	VERFPB:
		print FichaPb
		jmp COMPARE
	VERFRB:
		print fichaRb
		jmp COMPARE
	VERFRIB:
		print fichaRIb
		jmp COMPARE
	VERFQB:
		print fichaQb
		jmp COMPARE
	VERVC:
		print vc
		jmp COMPARE
	FIN:
		POP AX
		POP SI
		print enter
endm

imprimirTodo macro len, fichaX, fichaO, y, vc, f, ln, enter
	LOCAL DO, VERFN, VERFB, VERFP, VERFQ, VERFR, VERFRI, VERVC, VERFPB, VERFRB, VERFRIB, VERFQB, FIN, COMPARE

	;000b->VACIO 	001b->FX 	100b->FO	010b->P		011b->Q		101b->R
	;1100b fichaPb    1101 fichaRb       1111 fichaRIb     1110 fichaQb
	;print ln
	print y
	PUSH SI
	PUSH AX
	xor si, si
	DO:
		mov al, [f+si] 
		cmp al, 001b
		je VERFB
		cmp al, 100b
		je VERFN
		cmp al, 010b
		je VERFP
		cmp al, 011b
		je VERFQ
		cmp al, 101b
		je VERFR
		cmp al, 110b
		je VERFRI
		cmp al, 1100b
		je VERFPB
		cmp al, 1101b
		je VERFRIB
		cmp al, 1111b
		je VERFRB
		cmp al, 1110b
		je VERFQB
		jmp VERVC
	COMPARE:
		inc si  
		cmp si, len  
		jb DO
		jmp FIN
	VERFB:
		print fichaX
		jmp COMPARE
	VERFN:
		print fichaO
		jmp COMPARE	
	VERFP:
		print fichaP
		jmp COMPARE	
	VERFQ:
		print fichaQ
		jmp COMPARE	
	VERFR:
		print fichaR
		jmp COMPARE	
	VERFRI:
		print fichaRI
		jmp COMPARE
	VERFPB:
		print FichaPb
		jmp COMPARE
	VERFRB:
		print fichaRb
		jmp COMPARE
	VERFRIB:
		print fichaRIb
		jmp COMPARE
	VERFQB:
		print fichaQb
		jmp COMPARE
	VERVC:
		print vc
		jmp COMPARE
	FIN:
		POP AX
		POP SI
		print enter
endm

imprimirHtml macro len, fb, fn, f, vb, vn, tr, ctr, handleFichero
	LOCAL DO, VERFN, VERFB, VERVB, VERVN, FIN, COMPARE
	PUSH SI
	PUSH AX
	xor si, si
	escribirArchivo SIZEOF tr, tr, handleFichero
	DO:
		mov al, [f+si]		;AQUI
		cmp al, 001b
		je VERFB
		cmp al, 100b
		je VERFN
		cmp al, 000b
		je VERVB
		jmp VERVN
	COMPARE:
		inc si 				;AQUI
		cmp si, len 		;AQUI
		jb DO
		jmp FIN
	VERFB:
		escribirArchivo SIZEOF fb, fb, handleFichero
		jmp COMPARE
	VERFN:
		escribirArchivo SIZEOF fn, fn, handleFichero
		jmp COMPARE	
	VERVB:
		escribirArchivo SIZEOF vb, vb, handleFichero
		jmp COMPARE
	VERVN:
		escribirArchivo SIZEOF vn, vn, handleFichero
		jmp COMPARE
	FIN:
		escribirArchivo SIZEOF ctr, ctr, handleFichero
		POP AX
		POP SI
endm

imprimirArq macro len, sc, spc, f, char0, char1, char2, char3, char4, handleFichero
	LOCAL DO, VERFN, VERFB, VERFP, VERFQ, VERFR, VERFRI, VERVC, VERFPB, VERFRB, VERFRIB, VERFQB, FIN, COMPARE
	PUSH SI
	PUSH AX
	xor si, si

	mov al, [f+si]
	cmp al, 001b
	je VERFB
	cmp al, 100b
	je VERFN
	cmp al, 010b
	je VERFP
	cmp al, 011b
	je VERFQ
	cmp al, 101b
	je VERFR
	cmp al, 110b
	je VERFRI
	cmp al, 1100b
	je VERFPB
	cmp al, 1101b
	je VERFRIB
	cmp al, 1111b
	je VERFRB
	cmp al, 1110b
	je VERFQB
	jmp VERVC

	DO:
		escribirArchivo SIZEOF sc, sc, handleFichero
		mov al, [f+si]
		cmp al, 001b
		je VERFB
		cmp al, 100b
		je VERFN
		cmp al, 010b
		je VERFP
		cmp al, 011b
		je VERFQ
		cmp al, 101b
		je VERFR
		cmp al, 110b
		je VERFRI
		cmp al, 1100b
		je VERFPB
		cmp al, 1101b
		je VERFRIB
		cmp al, 1111b
		je VERFRB
		cmp al, 1110b
		je VERFQB
		jmp VERVC
	COMPARE:
		inc si 				;AQUI
		cmp si, len 		;AQUI
		jb DO
		jmp FIN
	VERFB:		;FX
		escribirArchivo SIZEOF char1, char1, handleFichero
		jmp COMPARE
	VERFN:		;FO
		escribirArchivo SIZEOF char2, char2, handleFichero
		jmp COMPARE	
	VERVC:		;VACIO
		escribirArchivo SIZEOF char0, char0, handleFichero
		jmp COMPARE
	VERFP:		;P	 
		jmp COMPARE	
	VERFQ:		;Q 
		jmp COMPARE	
	VERFR:		;R
		escribirArchivo SIZEOF char3, char3, handleFichero
		jmp COMPARE	
	VERFRI:		;RI
		escribirArchivo SIZEOF char4, char4, handleFichero 
		jmp COMPARE
	VERFPB:		;BLANCA P
		jmp COMPARE
	VERFRB:		;BLANCA R
		escribirArchivo SIZEOF char3, char3, handleFichero
		jmp COMPARE
	VERFRIB:	;BLANCA RI
		escribirArchivo SIZEOF char4, char4, handleFichero
		jmp COMPARE
	VERFQB:		;BLANCA Q
		jmp COMPARE
	FIN:
		escribirArchivo SIZEOF spc, spc, handleFichero
		POP AX
		POP SI
endm

;************************** JUGABILIDAD **********************************

verificarCoordenadas macro f1, col1, buffer, m1, m2, m3, tipoCoord
	LOCAL DO1, DO2, LETRA1, LETRA2, LETRA3, LETRA4, LETRA5, NUM1, NUM2, NUM3, NUM4, NUM5, ULTIMO, FIN

	PUSH SI
	PUSH AX
	xor si, si
	DO1:
		mov tipoCoord, 0b
		mov al, buffer[si]
		cmp al, 41h
		je LETRA1
		cmp al, 42H
		je LETRA2
		cmp al, 43H
		je LETRA3
		cmp al, 44H
		je LETRA4
		cmp al, 45h
		je LETRA5
		jmp ERROR_COORD

	DO2:
		xor al, 0
		mov al, buffer[si]
		cmp al, '1'
		je NUM1
		cmp al, '2'
		je NUM2
		cmp al, '3'
		je NUM3
		cmp al, '4'
		je NUM4
		cmp al, '5'
		je NUM5
		jmp ERROR_COORD

	LETRA1:
		inc si
		mov col1, 45h
		jmp DO2


	LETRA2:
		inc si
		mov col1, 44h
		jmp DO2


	LETRA3:
		inc si
		mov col1, 43h
		jmp DO2


	LETRA4:
		inc si
		mov col1, 42h
		jmp DO2


	LETRA5:
		inc si
		mov col1, 41h
		jmp DO2

	NUM1:
		inc si
		mov f1, '1'
		jmp ULTIMO

	NUM2:
		inc si
		mov f1, '2'
		jmp ULTIMO

	NUM3:
		inc si
		mov f1, '3'
		jmp ULTIMO

	NUM4:
		inc si
		mov f1, '4'
		jmp ULTIMO

	NUM5:
		inc si
		mov f1, '5' 
		jmp ULTIMO

	ULTIMO:
		mov al, [buffer+si]
		cmp al, 24h	;'$'
		je FIN
		jmp ERROR_COORD

	FIN:
		POP AX
		POP SI
endm

obtenerPos macro col, pos
	LOCAL P1, P2, P3, P4, P5, FIN

	mov al, col
	cmp al, 41h
	je P1
	cmp al, 42H
	je P2
	cmp al, 43H
	je P3
	cmp al, 44H
	je P4
	cmp al, 45h
	je P5 

	P1:
		mov pos, 001b
		jmp FIN
	P2:
		mov pos, 010b
		jmp FIN
	P3:
		mov pos, 011b
		jmp FIN
	P4:
		mov pos, 100b
		jmp FIN
	P5:
		mov pos, 101b
		jmp FIN 
	FIN: 

endm

validarOrilla macro f1, col
	LOCAL COMP, ERROR, FIN  
	cmp f1, '4'
	je COMP
	cmp f1, '3'
	je COMP
	cmp f1, '2'
	je COMP 
	jmp FIN
	COMP:
		mov al, col 
		cmp al, 42H
		je ERROR
		cmp al, 43H
		je ERROR
		cmp al, 44H
		je ERROR
		jmp FIN
	ERROR:
		jmp ERROR_ORILLA
	FIN:

endm

opcionesMovimiento macro f1, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
	LOCAL F5, F4, F3, FIN, F22, PR, QR, PRI, QRI, PRIR, QRIR, PQR2, PQRI2, PQR3, PQRI3, PQR4, PQRI4, F11
	cmp f1, '5'
	je F5
	cmp f1, '4'
	je F4
	cmp f1, '3'
	je F3
	cmp f1, '2'
	je F22
	cmp f1, '1'
	je F11
	jmp INGRESAR
	F5:
		cmp pos1, 001b
		je QR

		cmp pos1, 101b
		je QRI
		 
		cmp pos1, 010b
		je QRIR

		cmp pos1, 011b
		je QRIR

		cmp pos1, 100b
		je QRIR 
		jmp FIN
	F4:
		cmp pos1, 001b
		je PQR4

		cmp pos1, 101b
		je PQRI4 
		jmp FIN
	F3:
		cmp pos1, 001b
		je PQR3

		cmp pos1, 101b
		je PQRI3
	 
		jmp FIN
	F22:
		cmp pos1, 001b
		je PQR2

		cmp pos1, 101b
		je PQRI2
 
		jmp FIN
	F11:
		cmp pos1, 001b
		je PR

		cmp pos1, 101b
		je PRI
		 
		cmp pos1, 010b
		je PRIR

		cmp pos1, 011b
		je PRIR

		cmp pos1, 100b
		je PRIR

		jmp FIN
	PR:				;ESQUINA INFERIOR IZQUIERDA
		Fp fila6, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fr fila1, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp FIN
	QR:								;ESQUINA SUPERIOR IZQUIERDA
		Fq fila7, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fr fila5, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp FIN
	PRI:							;ESQUINA INFERIOR DERECHA
		Fp fila6, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fri fila1, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp FIN
	QRI:							;ESQUINA SUPERIOR DERECHA
		Fq fila7, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fri fila5, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp FIN
	PRIR:							;CENTROS INFERIORES
		Fp fila6, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fr fila1, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fri fila1, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp FIN
	QRIR:							;CENTROS SUPERIORES
		Fq fila7, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fr fila5, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fri fila5, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp FIN
	PQR2:							;LADO DERECHO
		Fp fila6, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fq fila7, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fr fila2, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp FIN
	PQRI2:							;LADO IZQUIERDO
		Fp fila6, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fq fila7, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fri fila2, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp FIN
	PQR3:							;LADO DERECHO
		Fp fila6, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fq fila7, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fr fila3, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp FIN
	PQRI3:							;LADO IZQUIERDO
		Fp fila6, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fq fila7, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fri fila3, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp FIN
	PQR4:							;LADO DERECHO
		Fp fila6, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fq fila7, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fr fila4, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp FIN
	PQRI4:							;LADO IZQUIERDO 
		Fp fila6, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fq fila7, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		Fri fila4, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp FIN
	FIN: 
endm

Fp macro f, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
	LOCAL VALIDACION1, FIN, M2
		PUSH SI
		PUSH DX
		xor si, si

		MOV DL, pos1
		MOV DH, 0
		MOV SI, DX

		VALIDACION1:
			cmp f[si], 1100b
			je M2 
			jmp FIN
		M2:  
			mov f[si], 010b
			jmp FIN

		FIN:	 
			POP DX
			POP SI
endm

Fq macro f, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
	LOCAL VALIDACION1, CompX, CompO, M1, FIN, M2
		PUSH SI
		PUSH DX
		xor si, si

		MOV DL, pos1
		MOV DH, 0
		MOV SI, DX

		VALIDACION1:
			cmp f[si], 1110b
			je M2
			jmp FIN

		M2: 
			mov f[si], 011b
			jmp FIN

		FIN:	 
			POP DX
			POP SI
endm

Fr macro f, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
	LOCAL VALIDACION1, CompX, CompO, M1, FIN, M2
		PUSH SI
		PUSH DX
		xor si, si

		MOV DL, 110b
		MOV DH, 0
		MOV SI, DX

		VALIDACION1:
			cmp f[si], 1111b
			je M2
			jmp FIN
		M2: 
			mov f[si], 101b
			jmp FIN

		FIN:	 
			POP DX
			POP SI
endm

Fri macro f, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
	LOCAL VALIDACION1, CompX, CompO, M1, FIN, M2
		LOCAL VALIDACION1, CompX, CompO, M1, FIN, M2
		PUSH SI
		PUSH DX
		xor si, si

		MOV DL, 000b
		MOV DH, 0
		MOV SI, DX

		VALIDACION1: 
			cmp f[si], 1101b
			je M2
			jmp FIN 
		M2: 
			mov f[si], 110b
			jmp FIN

		FIN:	 
			POP DX
			POP SI
endm

findYAxis1 macro f1, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
	LOCAL F5, F4, F3, FIN, F22, F11
	cmp f1, '1'
	je F11
	cmp f1, '2'
	je F22
	cmp f1, '3'
	je F3
	cmp f1, '4'
	je F4
	cmp f1, '5'
	je F5
	jmp INGRESAR
	F5:
		findXAxis1 fila5, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		je FIN
	F4:
		findXAxis1 fila4, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		je FIN
	F3:
		findXAxis1 fila3, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		je FIN
	F22:
		findXAxis1 fila2, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		je FIN
	F11:
		findXAxis1 fila1, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		je FIN
	FIN:
		
endm

findXAxis1 macro f, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
	LOCAL VALIDACION1, CompX, CompO, M1, FIN, M2
	PUSH SI
	PUSH DX
	xor si, si

	MOV DL, pos1
	MOV DH, 0
	MOV SI, DX

	VALIDACION1:
		cmp turno, 0b
		je CompX

		cmp turno, 1b
		je CompO

	CompX:
		cmp f[si], 000b
		je M1;VALIDACION2

		cmp f[si], 100b
		jmp ERROR_SEL

		jmp FIN

	CompO: 
		cmp f[si], 000b
		je M2;VALIDACION2

		cmp f[si], 001b
		jmp ERROR_SEL

		jmp FIN

	M1:
		mov f[si], 001b
		jmp FIN;M2

	M2: 
		mov f[si], 100b
		jmp FIN

	FIN:	
		;MENSAJE
		POP DX
		POP SI
endm


;******************* MACROS PARA COMPARACION DE COMANDOS ****************

comparacion1 macro comandoE, buffer
	PUSH SI
	PUSH AX
	xor si, si

	mov CX, 50
	mov AX, DS
	mov ES, AX
	lea si, comandoE
	lea di, buffer
	
	repne cmpsw
	je MenuPrincipal

	POP AX
	POP SI
endm

comparacion2 macro comandoS, buffer
	PUSH SI
	PUSH AX
	xor si, si

	mov CX, 50
	mov AX, DS
	mov ES, AX
	lea si, comandoS
	lea di, buffer
	repne cmpsw
	je SAVE
	
	POP AX
	POP SI
endm

comparacion3 macro comandoS, buffer
	PUSH SI
	PUSH AX
	xor si, si

	mov CX, 50
	mov AX, DS
	mov ES, AX

	lea si, comandoS
	lea di, buffer
	repne cmpsw
	je SHOW
	
	POP AX
	POP SI
endm

comparacionP macro P, buffer
	PUSH SI
	PUSH AX
	xor si, si

	mov CX, 50
	mov AX, DS
	mov ES, AX
	lea si, P
	lea di, buffer
	repne cmpsw
	je INSERTARP
	
	POP AX
	POP SI
endm

comparacionQ macro Q, buffer
	PUSH SI
	PUSH AX
	xor si, si

	mov CX, 50
	mov AX, DS
	mov ES, AX
	lea si, Q
	lea di, buffer
	repne cmpsw
	je INSERTARQ
	
	POP AX
	POP SI
endm

comparacionR macro R, buffer
	PUSH SI
	PUSH AX
	xor si, si

	mov CX, 50
	mov AX, DS
	mov ES, AX
	lea si, R
	lea di, buffer
	repne cmpsw
	je INSERTARR
	
	POP AX
	POP SI
endm

comparacionRI macro RI, buffer
	PUSH SI
	PUSH AX
	xor si, si

	mov CX, 50
	mov AX, DS
	mov ES, AX
	lea si, RI
	lea di, buffer
	repne cmpsw
	je INSERTARRI
	
	POP AX
	POP SI
endm

;*************************** MACROS PARA LOS ARCHIVOS *******************************
Ruta macro buffer
	LOCAL INICIO,FIN
	xor si,si
	INICIO:
		getChar
		cmp al,0dh
		je FIN
		mov buffer[si],al
		inc si
		jmp INICIO
	FIN:
		mov buffer[si],00h;AÑADIR EL .ARQ
endm

crearArchivo macro buffer,handle
	mov ah,3ch
	mov cx,00h
	lea dx,buffer
	int 21h
	mov handle,ax
	jc ErrorCrear
endm

abrirArchivo macro ruta,handle
	mov ah,3dh
	mov al,10b
	lea dx,ruta
	int 21h
	mov handle,ax
	jc ErrorAbrir
endm

leerArchivo macro numbytes,buffer,handle
    mov ah,3fh
    mov bx,handle
    mov cx,numbytes
    lea dx,buffer
    int 21h
    jc ErrorLeer
endm

cerrarArchivo macro handle
	mov ah,3eh
	mov handle,bx
	int 21h
endm

escribirArchivo macro numbytes,buffer,handle
	mov ah, 40h
	mov bx,handle
	mov cx,numbytes
	lea dx,buffer
	int 21h
	jc ErrorEscribir
endm

fecha macro
	LOCAL getD, getM, getA
	PUSH SI
	PUSH AX
	xor si, si

	MOV AH,2AH    ; To get System Time
	INT 21H
	
	getD:
		MOV AL,DL     ; Hour is in CH
		CALL Siguiente
		MOV AL, 2fh		; '/'
		MOV bufferFecha[si], AL
		inc si
	getM:
		MOV AL,DH     ; Minutes is in CL
		CALL Siguiente
		MOV AL, 2fh		; '/'
		MOV bufferFecha[si], AL
		inc si
	getA:
		MOV AL,DH     ; Seconds is in DH
		ADD CX,0F830H ; To negate the effects of 16bit value,
		MOV AX,CX     ; since AAM is applicable only for AL (YYYY -> YY)
		CALL Siguiente

	POP AX
	POP SI
endm

hora macro
	LOCAL getH, getM, getS
	PUSH SI
	PUSH AX
	xor si, si

	MOV AH,2CH    ; To get System Time
	INT 21H
	
	getH:
		MOV AL,CH     ; Hour is in CH
		CALL Sig
		MOV AL, 3ah		; ':'
		MOV bufferHora[si], AL
		inc si
	getM:
		MOV AL,CL     ; Minutes is in CL
		CALL Sig
		MOV AL, 3ah		; ':'
		MOV bufferHora[si], AL
		inc si
	getS:
		MOV AL,DH     ; Seconds is in DH
		CALL Sig

	POP AX
	POP SI
endm