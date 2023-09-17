	.data
pi:	.float 3.14159265359
a:	.word 2
b:	.word 3
r:	.asciiz "El resultado es \n"
texto:	.asciiz "Ingrese el valor del radio \n"

	.text
	.globl main

main: 
	#Pedir dato entrada
	#Imprimir cadena de texto
	li $v0, 4
	la $a0, texto
	syscall
	
	li $v0, 6
	syscall
	movf.s $f2, $f0 

	#multiplicacion enteros
	lw $t1,a
	lw $t2,b
	mul $t0, $t1, $t2
	
	#multiplicacion flotantes
	#mtc1 $t0,$f1
	#cvt.s.w $f2,$f1
	

	mtc1 $t1, $f4
	cvt.s.w $f6,$f4
	lwc1 $f0, pi
	mul.s $f5,$f6,$f2
	mul.s $f12,$f5,$f0
	
	#Resultado por pantalla
	la $a0,r
	li $v0,4
	syscall
	
	li $v0,2
	syscall