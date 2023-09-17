.data
    prompt: .asciiz "Ingrese un �ngulo en grados: "
    menuP: .asciiz	"\nElige una funci�n:\n1. Movimiento circular uniformemente acelerado\n2. Seno\n3. Seno inverso\n4. Secante\n5. Secante inversa\n6. ax + b = y\n7. Salir\n"
    invalid_msg: .asciiz "Opci�n inv�lida. Intente de nuevo.\n"
    result_msg: .asciiz "Resultado: "
    pi: .double 3.14159265359
    zero: .double	0.0
    two: .double	2.0
    one: .double	1.0
    degree: .double 180 #  (pi/180)
    
.text
.globl main
# Funci�n para mostrar el men�
menu:
    #print_msg prompt     # Pedir �ngulo por consola
    #read_float $f12      # Leer �ngulo
    #print_newline        # Imprimir salto de l�nea    
    # Imprimir opciones del men�
    li $v0, 4
    la $a0, menuP
    syscall
       
    # Leer opci�n del usuario
    li $v0, 5
    syscall
    move $a0, $v0        # Guardar la opci�n en $a0
    # Saltar a la funci�n correspondiente
    beq $a0, 1, mcua
    beq $a0, 2, sine
    beq $a0, 3, asin
    beq $a0, 4, sec
    beq $a0, 5, asec
    beq $a0, 6, linear_eq
    beq $a0, 7, exit
    j invalid_option
# Funci�n para manejar opciones inv�lidas
invalid_option:
    li $v0, 4
    la $a0, invalid_msg
    syscall
    j menu    
# Funci�n principal
main:
    j menu
exit:
    li $v0, 10        # Salir del programa
    syscall   

mcua:
    # C�digo para el Movimiento Circular Uniformemente Acelerado
    # ...

    # Devolver el resultado en $f0
    # ...
    jr $ra

# Funci�n: Seno
sine:
	# Pedir angulo
    li $v0, 4
    la $a0, prompt
    syscall
       
    # Leer �ngulo en $f0
    li $v0, 7
    syscall
    #b convertir_a_radianes
    l.d $f12, pi		#Cargar pi
    l.d $f8, degree 		# Cargar 180
    mul.d $f10, $f0, $f12	#angulo * pi
    div.d $f12, $f10, $f8  	# (angulo*pi) / 180.0
    
    
    # $f12 contiene el �ngulo en radianes
    # $f0 contendr� el resultado
    
    l.d $f0, zero   # Inicializar el resultado en 0.0
    l.d $f2, one   # Inicializar el t�rmino actual en 1.0
    l.d $f4, one   # Inicializar el factorial en 1.0
    l.d $f6, one   # Inicializar el exponente en 1.0
    
    li $t0, 20      # N�mero de t�rminos en la serie
    
seno_loop:
    div.d $f2, $f2, $f4  # x^n / n!
    mul.d $f2, $f2, $f12  # (x^n / n!) * angulo
    add.d $f0, $f0, $f2  # Sumar al resultado
    mul.d $f4, $f4, $f6  # Incrementar el factorial por 2
    add.d $f6, $f6, $f6  # Incrementar el exponente por 2
    
    subi $t0, $t0, 1     # Decrementar el contador de t�rminos
    bnez $t0, seno_loop  # Si no hemos terminado, continuar
    
    j respuesta


respuesta:
	
	li $v0, 3        # Cargar el c�digo de la llamada al sistema para imprimir un flotante
	syscall
	j menu
# Funci�n: Seno inverso
    # x: $f12 (entrada), result: $f0 (salida)
asin:
    l.d $f0, zero        # Inicializar el resultado con x
    l.d $f2, one         # Inicializar el factorial en 1.0
    l.d $f4, one         # Inicializar el exponente en 1.0
    l.d $f6, one         # Inicializar el t�rmino actual en 1.0
    
asin_loop:
    div.d $f4, $f4, $f2  # x^n / n!
    mul.d $f4, $f4, $f4  # (x^n / n!)^2
    mul.d $f0, $f0, $f4  # x * (x^n / n!)^2
    sub.d $f12, $f12, $f0 # Restar al resultado
    mul.d $f2, $f2, $f12 # n! *= x
    mul.d $f12, $f12, $f12 # x^2
    add.d $f4, $f4, $f4  # Incrementar el exponente por 2
    
    c.lt.s $f4, $f7      # Compara el t�rmino actual con 0.0
    bc1t asin_end        # Si es menor, termina
    
    j asin_loop
    
asin_end:
    j respuesta

# Funci�n: Secante
sec:
    l.d $f0, one         # Inicializar el resultado en 1.0
    l.d $f12, two        # Cargar x en $f12
    l.d $f2, one         # Inicializar el factorial en 1.0
    l.d $f4, one         # Inicializar el exponente en 1.0
    l.d $f6, one         # Inicializar el t�rmino actual en 1.0
    
sec_loop:
    div.d $f6, $f6, $f2  # x^n / n!
    mul.d $f6, $f6, $f4  # (x^n / n!) * (2n-1)/(2n)
    add.d $f0, $f0, $f6  # Sumar al resultado
    mul.d $f2, $f2, $f12 # n! *= x
    mul.d $f12, $f12, $f12 # x^2
    add.d $f4, $f4, $f4  # Incrementar el exponente por 2
    
    c.lt.s $f6, $f7      # Compara el t�rmino actual con 0.0
    bc1t sec_end         # Si es menor, termina
    
    
    j sec_loop
    
sec_end:
    j respuesta



# Funci�n: Secante inversa
asec:
    l.d $f0, one         # Inicializar el resultado en 1.0
    l.d $f2, one         # Inicializar el factorial en 1.0
    l.d $f4, one         # Inicializar el exponente en 1.0
    l.d $f6, one         # Inicializar el t�rmino actual en 1.0
    
asec_loop:
    div.d $f4, $f4, $f2  # x^n / n!
    mul.d $f4, $f4, $f4  # (x^n / n!)^2
    mul.d $f0, $f0, $f4  # x * (x^n / n!)^2
    sub.d $f12, $f12, $f0 # Restar al resultado
    mul.d $f2, $f2, $f12 # n! *= x
    mul.d $f12, $f12, $f12 # x^2
    add.d $f4, $f4, $f4  # Incrementar el exponente por 2
    
    c.lt.s $f4, $f7      # Compara el t�rmino actual con 0.0
    bc1t asec_end        # Si es menor, termina
    
    
    j asec_loop
    
asec_end:
    j respuesta   
        
# Funci�n: ax + b = y
linear_eq:
    # C�digo para resolver la ecuaci�n ax + b = y
    # ...

    # Devolver el resultado en $f0
    # ...
    jr $ra                    
    
# Funci�n para imprimir un mensaje
print_msg:
    li $v0, 4
    syscall
    jr $ra
    
    
    
    
# Funci�n para leer un valor flotante desde la consola
read_float:
    li $v0, 6
    syscall
    jr $ra
    
# Funci�n para imprimir un valor flotante
print_float:
    li $v0, 2
    syscall
    jr $ra




