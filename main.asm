;================================= INCLUYO MACROS =================================
include macros.asm

;================================= TIPO DE EJECUTABLE =================================
.MODEL small 
.STACK 

;================================= DECLARACION DE VARIABLES =================================
.DATA
;GENERALES
encabezadoP1 db 0ah, 0ah, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 10, 'FACULTAD DE INGENIERIA', 10,13, 'ESCUELA DE CIENCIAS Y SISTEMAS', 10,13, 'CURSO: ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', '$'
encabezadoP2 db 0ah, 'NOMBRE: Daniel Estuardo Chicas Carias', 10,13, 'CARNET: 201807079', 10,13, 'SECCION: A', 10,13, 10,13, '$' 
menuOpciones db 0ah, '========== MENU PRINCIPAL ==========', 10,13,'1) Iniciar Juego    U.u', 10,13,'2) Cargar Partida   :o', 10,13,'3) Salir            :c', 10,13,10,13,'>','$' 
pruebanuevo db 0ah, "NUEVO", "$"
pruebacarga db 0ah, "CARGA", "$"
pruebasalir db 0ah, "SALIR", "$"


;VARIABLES INICIAR JUEGO
	msg_nvo db 0ah, 0dh, '********** NUEVO JUEGO **********', 10,13, '$' ;10, TEMPORAL
	y7 db '   ', '$'
	y6 db '   ', '$'
	y5 db ' 1 ', '$'
	y4 db ' 2 ', '$'
	y3 db ' 3 ', '$'
	y2 db ' 4 ', '$'
	y1 db ' 5 ', '$'



	fichaPb db  '       ', '$'
	fichaQb db  '       ', '$'
	fichaRb db  '      |', '$'
	fichaRIb db '       ', '$'
	fichaX db  '  X   |', '$'
	fichaO db  '  O   |', '$'
	fichaP db  ' P(v)  ', '$'
	fichaQ db  ' Q(^)  ', '$'
	fichaR db  ' R(>) |', '$'
	fichaRI db ' R(<)  ', '$'

	vc db '      |', '$'
	ln db '------------------------------------', 10,13, '$'
	xcord db 0ah, 0dh, 32,32,32,32,32, '        E      D      C      B      A', 10,13,'$'
	turno1 db 0ah, 0dh, ' > Turno Jugador 1: ', '$'
	turno2 db 0ah, 0dh, ' > Turno Jugador 2: ', '$'
	saltoLinea db 0ah, 0dh, '$'
	salto db 0ah, 0dh, 00h
;000b->VACIO 	001b->FX 	100b->FO	010b->P		011b->Q		101b->R 
;1100b fichaPb    1101 fichaRb       1111 fichaRIb     1110 fichaQb

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
	temp db '$'
	bin db 000b
	tipoCoord db 0b
	filaSelec1 db 8 dup(000b)
	division db '---------------------------------------------', '$' 
	msg_coord1 db '-- Casilla Destino --', 10,13, '$'
	msg_coord2 db '-- Casilla Fuente, Destino --', 10,13, '$'
	msg_movimiento db '-- Movimiento Realizado --', 10,13, '$'
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
	rutaNomHtml db 'AETab.html', 00h
	handleFichero dw ?
	msmError1 db 0ah,0dh,'Error al abrir archivo','$' 
	msmError2 db 0ah,0dh,'Error al leer archivo','$'
	msmError3 db 0ah,0dh,'Error al crear archivo','$'
	msmError4 db 0ah,0dh,'Error al Escribir archivo','$'

;VARIABLES DE CARGA DEL JUEGO
	m1 db 0ah, 0dh, '-------- 1 --------', '$'
	m2 db 0ah, 0dh, '-------- 2 --------', '$'
	m3 db 0ah, 0dh, '-------- 3 --------', '$'

;VARIABLES COMANDOS
	comandoExit db 'E','X','I','T','$'
	comandoSave db 'S','A','V','E','$'
	comandoShow db 'S','H','O','W','$'
	extension db '.arq', '$'
	char0 db '0'
	char1 db '1'
	char4 db '4'
	char7 db '7'
	msg_salir db 0ah, 0dh, '-------- PARTIDA FINALIZADA --------', '$'

	msg_guardar db 0ah, 0dh, '-------- GUARDANDO PARTIDA --------', 10,13,'$'
	cinNomArch db 0ah, 0dh, '>Ingrese nombre para guardar: ', '$'
	msg_guardad db 0ah, 0dh, '-------- Partida Guardada Con Exito --------', '$'

	msg_generar db 0ah, 0dh, '-------- GENERANDO ARCHIVO --------', 10,13,'$'
	infoNomArch db 0ah, 0dh, '>Nombre archivo: AETab.html', '$'
	msg_generad db 0ah, 0dh, '--- Visualizacion Generada Con Exito ---', 10,13, '$'

;==================== DECLARACION DE CODIGO =============================

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
		verificarCoordenadas f1, col1, bufferLectura, m1, m2, m3, tipoCoord
		validarOrilla f1, col1
		obtenerPos col1, pos1
		opcionesMovimiento f1, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		
		
		;findYAxis1 f1, pos1,fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno


		jmp CAMBIAR_TURNO 

	JUG2:
		print turno2
		ObtenerTexto bufferLectura
		comparacion1 comandoExit, bufferLectura
		comparacion2 comandoSave, bufferLectura
		comparacion3 comandoShow, bufferLectura
		verificarCoordenadas f1, col1, bufferLectura, m1, m2, m3, tipoCoord
		validarOrilla f1, col1
		obtenerPos col1, pos1
		opcionesMovimiento f1, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
		
		
		;findYAxis1 f1, pos1, fila6, fila5, fila4, fila3, fila2, fila1, fila7, turno
 


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

;************************************************************************************ COMANDOS *********************************************************************
	SAVE:
		print msg_guardar
		print cinNomArch
		Ruta rutaArchivo
		crearArchivo rutaArchivo,handleFichero
		abrirArchivo rutaArchivo,handleFichero
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


main endp
end