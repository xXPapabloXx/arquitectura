.data	
anglePrompt: 	.ascii	"Ingrese angulo en grados:\n"
resultado: 	.ascii	"Resultado: \n"
pi: 		.double 3.14159265359
norm: .double 360.0
radians: .double 180.0
zero: .double 0.0

.text 
.globl main
	
main: 
	
	li $v0, 4
	la $a0, anglePrompt
	syscall 
		#ingreso de angulo en $f0 como double
	li $v0, 7
	syscall
		
	li $t0, 5 		#$t0 = iteraciones de maclaurin
	jal normalizar
	jal seno
	

normalizar:
	l.d $f14, norm	
	c.le.d $f14, $f0         # Compare angle with 360
	bc1f radian 		    # If angle <= 360, convertir a radianes
	div.d $f0, $f0, $f14
	c.le.d 1, $f14, $f0
	bc1f normalizar
	
radian:
	l.d $f14, radians
	l.d $f16, pi
	div.d $f18, $f16, $f14
	mul.d $f12, $f0, $f18	#$f12 = angulo en radianes
	jr $ra
	
seno:
	#x - (pow(x,3)/3!) + (pow(x,5)/5!) - ...	
	#$f28 = resultado aproximacion
	#$t1 = iterador (k)
	#$f26 = potencia
	#$t2 = factorial
	#$f12 = angulo en radianes
	#$t3 = 2k+1
	#$t6 = bandera signo
	li $t1, 1
	l.d $f28, zero
	l.d $f26, zero
	add.d $f28, $f28,$f12 	#resultado aproximado	
	add.d $f26, $f26,$f12 	#potencia
	li $t6, 2
	
loop:
	bge $t1, $t0, salir			
	mul $t3, $t1, 2		#calculo de t3
	add $t3, $t3, 1		#calculo de t3
	
	li $t4, 1 			#contador temporal
	jal potencia
	li $t2, 1 			#factorial
	li $t4, 1 			#contador temporal
	jal factorial 		#Está el resultado en $t2	
	mtc1 $t2, $f2			#factorial en double	
	cvt.d.w $f2, $f2		#word a double para operar
	div.d $f22, $f26, $f2	#potencia / factorial
	
	beq $t6, 1, sumar
	beq $t6, 2, restar
		
	addi $t1, $t1, 1
	j loop
	
sumar:
	add.d $f28, $f28, $f22
	addi $t1, $t1, 1
	li $t6, 2
	j loop

restar: 
	sub.d $f28, $f28, $f22
	addi $t1, $t1, 1
	li $t6, 1
	j loop	
	
potencia:	
	bge $t4, $t3, volver
	mul.d $f26, $f26, $f12
	addi $t4, $t4, 1	
	j potencia

factorial:
	bgt  $t4, $t3, volver
	mul $t2, $t2, $t4
	addi $t4, $t4, 1
	j factorial
	
volver: 
	jr $ra
		
salir: 
	mov.d $f12, $f28
	li $v0, 4
	la $a0, resultado
	syscall
	
	li $v0, 3
	syscall
	
	li $v0, 10
	syscall
	
