include macros.asm
.MODEL small 
.STACK 

;*************************************************************** DECLARACION DE VARIABLES ***************************************************************************
.DATA
;GENERALES
	encabezadoP1 db 0ah, 0ah, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 10, 'FACULTAD DE INGENIERIA', 10,13, 'ESCUELA DE CIENCIAS Y SISTEMAS', 10,13, 'CURSO: ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', '$'
	encabezadoP2 db 0ah, 'NOMBRE: Daniel Estuardo Chicas Carias', 10,13, 'CARNET: 201807079', 10,13, 'SECCION: A', 10,13, 10,13, '$' 
	menuOpciones db 0ah, '========== MENU PRINCIPAL ==========', 10,13,'1) Iniciar Juego    U.u', 10,13,'2) Cargar Partida   :o', 10,13,'3) Salir            :c', 10,13,10,13,'>','$' 
	insertar db 0ah, "> Inserte la posicion para ingresar la pieza: ", "$"

	pruebacarga db 0ah, "CARGA", "$"
	pruebasalir db 0ah, "SALIR", "$"



;VARIABLES INICIAR JUEGO
	msg_nvo db 0ah, 0dh, '********** NUEVO JUEGO **********', 10,13, '$' ;10, TEMPORAL
	y7 db '   ', '$'
	y6 db '   ', '$'
	y5 db ' 5 ', '$'
	y4 db ' 4 ', '$'
	y3 db ' 3 ', '$'
	y2 db ' 2 ', '$'
	y1 db ' 1 ', '$'



	fichaPb db  '     ', '$'
	fichaQb db  '     ', '$'
	fichaRb db  '     ', '$'
	fichaRIb db '    |', '$'
	fichaX db  ' X  |', '$'
	fichaO db  ' O  |', '$'
	fichaP db  'P(v) ', '$'
	fichaQ db  'Q(^) ', '$'
	fichaR db  'R(<) ', '$'
	fichaRI db 'R(>)|', '$'

	vc db '    |', '$'
	ln db '------------------------------------', 10,13, '$'
	xcord db 0ah, 0dh, 32,32,32,32,32, '    E    D    C    B    A', 10,13,'$'
	turno1 db 0ah, 0dh, ' > Turno Jugador 1: ', '$'
	turno2 db 0ah, 0dh, ' > Turno Jugador 2: ', '$'
	saltoLinea db 0ah, 0dh, '$'
	salto db 0ah, 0dh, 00h
;000b->VACIO 	001b->FX 	100b->FO	010b->P		011b->Q		101b->R  

	fila6 db 1100b, 1100b, 1100b, 1100b, 1100b, 1100b
	fila5 db 1101b, 000b, 000b, 000b, 000b, 000b, 1111b
	fila4 db 1101b, 000b, 000b, 000b, 000b, 000b, 1111b
	fila3 db 1101b, 000b, 000b, 000b, 000b, 000b, 1111b
	fila2 db 1101b, 000b, 000b, 000b, 000b, 000b, 1111b
	fila1 db 1101b, 000b, 000b, 000b, 000b, 000b, 1111b
	fila7 db 1110b, 1110b, 1110b, 1110b, 1110b, 1110b, 1110b

	fil6 db 1100b, 1100b, 1100b, 1100b, 1100b, 1100b, 1100b
	fil5 db 1101b, 000b, 000b, 000b, 000b, 000b, 1111b
	fil4 db 1101b, 000b, 000b, 000b, 000b, 000b, 1111b
	fil3 db 1101b, 000b, 000b, 000b, 000b, 000b, 1111b
	fil2 db 1101b, 000b, 000b, 000b, 000b, 000b, 1111b
	fil1 db 1101b, 000b, 000b, 000b, 000b, 000b, 1111b
	fil7 db 1110b, 1110b, 1110b, 1110b, 1110b, 1110b, 1110b

;DETALLES DEL JUEGO
	turno db 0b
	f1 db 1 dup('$')
	col1 db 1 dup('$')
	pos1 db 0b
	f2 db 1 dup('$') 
	pos2 db 0b

	aux db 0b

	separadorPC db ';'
	separadorComa db ',' 
	tipoCoord db 0b 
	division db '---------------------------------', '$'    
	msg_errorC db '-- Atencion, Coordenadas Erroneas --', 10,13, '$'
	msg_PosOcupada db 0ah,0dh,'-------- Esta ficha ya fue ocupada por el contrincante --------','$' 
	msg_Orilla db 0ah, 0dh, '-------- Solo se pueden seleccionar fichas posicionadas en el perimetro del cuadrado --------', '$'

;VARIABLES FICHERO
	guion db '-'
	bufferHora db 8 dup('0')
	bufferFecha db 8 dup('0')
	rutaArchivo db 100 dup('$')
	bufferLectura db 200 dup('$')
	bufferEscritura db 200 dup('$')
	rutaNomHtml db 'SHOWHTM.htm', 00h
	handleFichero dw ?
	msmError1 db 0ah,0dh,'Error al abrir archivo','$' 
	msmError2 db 0ah,0dh,'Error al leer archivo','$'
	msmError3 db 0ah,0dh,'Error al crear archivo','$'
	msmError4 db 0ah,0dh,'Error al Escribir archivo','$'

;VARIABLES DE CARGA DEL JUEGO
	char0 db 	'0'
	char1 db 	'X'
	char2 db 	'O'
	char3 db 	'3'
	char4 db 	'4'
	
;VARIABLES COMANDOS
	comandoExit db 'EXIT','$'
	comandoSave db 'SAVE','$'
	comandoShow db 'SHOWHTM', '$'
	comandoP db 	'P', '$'
	comandoQ db 	'Q', '$'
	comandoR db 	'R', '$'
	comandoRI db 	'RI', '$'

	extension db '.arq', '$'
	msg_salir db 0ah, 0dh, '-------- PARTIDA FINALIZADA --------', '$'

	msg_guardar db 0ah, 0dh, '-------- GUARDANDO PARTIDA --------', 10,13,'$'
	cinNomArch db 0ah, 0dh, '>Ingrese nombre para guardar: ', '$'
	msg_guardad db 0ah, 0dh, '-------- Partida Guardada Con Exito --------', '$'

	msg_generar db 0ah, 0dh, '-------- GENERANDO ARCHIVO --------', 10,13,'$'
	infoNomArch db 0ah, 0dh, '>Nombre archivo: SHOWHTM.htm', '$'
	msg_general db 0ah, 0dh, '--- Archivo Creado Con Exito ---', 10,13, '$'

;HTML
	inicioHtml db '<html>', 10,13, '<head>', 10,13,9, '<title>201807079</title>', 10,13, '</head>', 10,13, '<body bgcolor=#A9A9A9>', 10,13,9, '<H1 align="center">', 00h ;20D08C;FED7CE
	cierreH1 db '</H1>', 10,13, 00h
	inicioTabla db 9, '<center>', 10,13, '<table border=0 cellspacing=2 cellpadding=2>', 10,13, 00h ; bgcolor=#005b96
	tr db 9,9, '<tr align=center>', 00h
	ctr db 0ah, 0dh, 9,9, '</tr>', 10,13, 00h
	finHtml db 9, '</table>', 10,13, '</center>', 10,13, '</body>', 10,13, '</html>', 00h
	fichaB db 0ah, 0dh, 9, '		<td bgcolor="cadetblue">X</td>', 00h
	fichaN db 0ah, 0dh, 9, '		<td bgcolor="burlywood">O</td>', 00h
	VacioB db 0ah, 0dh, 9, '		<td bgcolor="white" width=47px; height=125px;> </td>', 00h
	VacioN db 0ah, 0dh, 9, '		<td bgcolor="brown" width=47px; height=125px;> </td>', 00h


;***************************************************************** DECLARACION DE CODIGO ****************************************************************************

.code
main proc
	Inicio:
		mov dx, @data
		mov ds, dx
		print encabezadoP1
		print encabezadoP2
		je MenuPrincipal

	MenuPrincipal:
		print menuOpciones
		getChar
		cmp al, '1'
		je NUEVO
		cmp al, '2'
		je CARGAR
		cmp al, '3'
		je SALIR 
		jmp NUEVO
    
    NUEVO:
		print msg_nvo 
		limpiar SIZEOF fil7, fila7, fil7
		limpiar SIZEOF fil6, fila6, fil6
		limpiar SIZEOF fil5, fila5, fil5
		limpiar SIZEOF fil5, fila4, fil4
		limpiar SIZEOF fil5, fila3, fil3
		limpiar SIZEOF fil5, fila2, fil2
		limpiar SIZEOF fil5, fila1, fil1
		mov turno, 0b 
		jmp INGRESAR 

	INGRESAR:
		imprimir SIZEOF fila6, fichaX, fichaO, y6, vc, fila6, ln, saltoLinea
		imprimir SIZEOF fila5, fichaX, fichaO, y5, vc, fila5, ln, saltoLinea
		imprimir SIZEOF fila4, fichaX, fichaO, y4, vc, fila4, ln, saltoLinea
		imprimir SIZEOF fila3, fichaX, fichaO, y3, vc, fila3, ln, saltoLinea
		imprimir SIZEOF fila2, fichaX, fichaO, y2, vc, fila2, ln, saltoLinea
		imprimir SIZEOF fila1, fichaX, fichaO, y1, vc, fila1, ln, saltoLinea
		imprimir SIZEOF fila7, fichaX, fichaO, y7, vc, fila7, ln, saltoLinea 
		print xcord
		print division
		cmp turno, 0b
		je JUG1
		cmp turno, 1b
		je JUG2
		jmp MenuPrincipal

	JUG1: 
		print turno1
		ObtenerTexto bufferLectura
		comparacion1 comandoExit, bufferLectura
		comparacion2 comandoSave, bufferLectura
		comparacion3 comandoShow, bufferLectura
		verificarCoordenadas f1, col1, bufferLectura, tipoCoord
		validarOrilla f1, col1
		obtenerPos col1, pos1
		opcionesMovimiento f1, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		
		imprimirTodo SIZEOF fila6, fichaX, fichaO, y6, vc, fila6, ln, saltoLinea
		imprimirTodo SIZEOF fila5, fichaX, fichaO, y5, vc, fila5, ln, saltoLinea
		imprimirTodo SIZEOF fila4, fichaX, fichaO, y4, vc, fila4, ln, saltoLinea
		imprimirTodo SIZEOF fila3, fichaX, fichaO, y3, vc, fila3, ln, saltoLinea
		imprimirTodo SIZEOF fila2, fichaX, fichaO, y2, vc, fila2, ln, saltoLinea
		imprimirTodo SIZEOF fila1, fichaX, fichaO, y1, vc, fila1, ln, saltoLinea
		imprimirTodo SIZEOF fila7, fichaX, fichaO, y7, vc, fila7, ln, saltoLinea 
		print xcord
		print division

		
		print insertar
		ObtenerTexto bufferLectura

		comparacionP comandoP, bufferLectura
		comparacionQ comandoQ, bufferLectura
		comparacionR comandoR, bufferLectura
		comparacionRI comandoRI, bufferLectura
			
		jmp CAMBIAR_TURNO

	JUG2:
		print turno2
		ObtenerTexto bufferLectura
		comparacion1 comandoExit, bufferLectura
		comparacion2 comandoSave, bufferLectura
		comparacion3 comandoShow, bufferLectura
		verificarCoordenadas f1, col1, bufferLectura, tipoCoord
		validarOrilla f1, col1
		obtenerPos col1, pos1
		opcionesMovimiento f1, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		
		imprimirTodo SIZEOF fila6, fichaX, fichaO, y6, vc, fila6, ln, saltoLinea
		imprimirTodo SIZEOF fila5, fichaX, fichaO, y5, vc, fila5, ln, saltoLinea
		imprimirTodo SIZEOF fila4, fichaX, fichaO, y4, vc, fila4, ln, saltoLinea
		imprimirTodo SIZEOF fila3, fichaX, fichaO, y3, vc, fila3, ln, saltoLinea
		imprimirTodo SIZEOF fila2, fichaX, fichaO, y2, vc, fila2, ln, saltoLinea
		imprimirTodo SIZEOF fila1, fichaX, fichaO, y1, vc, fila1, ln, saltoLinea
		imprimirTodo SIZEOF fila7, fichaX, fichaO, y7, vc, fila7, ln, saltoLinea 
		print xcord
		print division

		print insertar
		ObtenerTexto bufferLectura

		comparacionP comandoP, bufferLectura
		comparacionQ comandoQ, bufferLectura
		comparacionR comandoR, bufferLectura
		comparacionRI comandoRI, bufferLectura
 
		jmp CAMBIAR_TURNO 

	INSERTARP:
		mov f2, '5'
		colocarXP f2, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp CAMBIAR_TURNO

	INSERTARQ:
		mov f2, '1'
		colocarXQ f2, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp CAMBIAR_TURNO

	INSERTARR:
		mov pos2, 101b
		colocarXR f1, pos2, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp CAMBIAR_TURNO

	INSERTARRI:
		mov pos2, 001b
		colocarXRI f1, pos2, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		jmp CAMBIAR_TURNO


	CAMBIAR_TURNO:
		cmp turno, 1b
		je A_JUG1
		cmp turno, 0b
		je A_JUG2


	A_JUG1:
		mov turno, 0b
		jmp INGRESAR

	A_JUG2:
		mov turno, 1b
		jmp INGRESAR

    CARGAR:
		print pruebacarga
		jmp MenuPrincipal

    SALIR:
		mov ah, 4ch
		int 21h

	VolverTurno:
		cmp turno, 0b
		je JUG1
		cmp turno, 1b
		je JUG2
		jmp MenuPrincipal

;************************************************************************************ COMANDOS **********************************************************************
	SAVE:
		print msg_guardar
		print cinNomArch
		Ruta rutaArchivo
		crearArchivo rutaArchivo,handleFichero
		abrirArchivo rutaArchivo,handleFichero  
		imprimirArq SIZEOF fila5, separadorComa, separadorPC, fila5, char0, char1, char2, char3, char4, handleFichero
		imprimirArq SIZEOF fila4, separadorComa, separadorPC, fila4, char0, char1, char2, char3, char4, handleFichero
		imprimirArq SIZEOF fila3, separadorComa, separadorPC, fila3, char0, char1, char2, char3, char4, handleFichero
		imprimirArq SIZEOF fila2, separadorComa, separadorPC, fila2, char0, char1, char2, char3, char4, handleFichero
		imprimirArq SIZEOF fila1, separadorComa, separadorPC, fila1, char0, char1, char2, char3, char4, handleFichero 
		cerrarArchivo handleFichero
		print msg_guardad
		jmp VolverTurno

	SHOW:
		print msg_generar
		print infoNomArch
		crearArchivo rutaNomHtml,handleFichero
		abrirArchivo rutaNomHtml,handleFichero 
		escribirArchivo SIZEOF inicioHtml, inicioHtml, handleFichero
		fecha
		hora
		escribirArchivo SIZEOF bufferFecha, bufferFecha, handleFichero
		escribirArchivo SIZEOF guion, guion, handleFichero
		escribirArchivo SIZEOF bufferHora, bufferHora, handleFichero
		escribirArchivo SIZEOF cierreH1, cierreH1, handleFichero
		escribirArchivo SIZEOF inicioTabla, inicioTabla, handleFichero  
		imprimirHtml SIZEOF fila5, fichaB, fichaN, fila5, VacioB, VacioN, tr, ctr, handleFichero
		imprimirHtml SIZEOF fila4, fichaB, fichaN, fila4, VacioB, VacioN, tr, ctr, handleFichero
		imprimirHtml SIZEOF fila3, fichaB, fichaN, fila3, VacioB, VacioN, tr, ctr, handleFichero
		imprimirHtml SIZEOF fila2, fichaB, fichaN, fila2, VacioB, VacioN, tr, ctr, handleFichero
		imprimirHtml SIZEOF fila1, fichaB, fichaN, fila1, VacioB, VacioN, tr, ctr, handleFichero 
		escribirArchivo  SIZEOF finHtml, finHtml, handleFichero
		cerrarArchivo handleFichero
		print msg_general
		jmp VolverTurno
	
;************************************************************************************ ERRORES ***********************************************************************
	
    ErrorLeer:
	    print msmError2
	   	getChar

	ERROR_COORD:
		print msg_errorC
		jmp VolverTurno 

	ERROR_SEL:
		print msg_PosOcupada
		jmp VolverTurno 
	
	ERROR_ORILLA:
		print msg_Orilla
		jmp VolverTurno
	
	ErrorCrear:
	    print msmError3
	    getChar
	    jmp VolverTurno

	ErrorAbrir:
	    print msmError1
	   	getChar
	   	jmp VolverTurno
	ErrorEscribir:
	    print msmError4
	   	getChar
	   	jmp VolverTurno


main endp


Siguiente proc
	AAM
	MOV BX,AX
	MOV DL,BH      ; Since the values are in BX, BH Part
	ADD DL,30H     ; ASCII Adjustment
	MOV bufferFecha[si], DL
	inc si 

	MOV DL,BL      ; BL Part 
	ADD DL,30H     ; ASCII Adjustment
	MOV bufferFecha[si], DL
	inc si 

	ret
Siguiente endp

Sig proc
	AAM
	MOV BX,AX
	MOV DL,BH      ; Since the values are in BX, BH Part
	ADD DL,30H     ; ASCII Adjustment
	MOV bufferHora[si], DL
	inc si 

	MOV DL,BL      ; BL Part 
	ADD DL,30H     ; ASCII Adjustment
	MOV bufferHora[si], DL
	inc si 

	ret
Sig endp

end