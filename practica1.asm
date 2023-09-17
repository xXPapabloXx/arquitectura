	.data

text: .asciiz "Ingrese el valor de A\n"
text2: .asciiz "Ingrese el valor de B\n"
text3: .asciiz "El resultado es\n"
	
	.text
	
	

	#Imprimir cadena de texto
	li $v0, 4
	la $a0, text
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	#Imprimir cadena de texto
	li $v0, 4
	la $a0, text2
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0
	add $a0, $s0, $s1
	
	li $v0, 1
	syscall
	
