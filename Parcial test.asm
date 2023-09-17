.data
    prompt: .asciiz "Ingrese un ángulo en grados: "
    menuP: .asciiz	"\nElige una función:\n1. Movimiento circular uniformemente acelerado\n2. Seno\n3. Seno inverso\n4. Secante\n5. Secante inversa\n6. ax + b = y\n7. Salir\n"
    invalid_msg: .asciiz "Opción inválida. Intente de nuevo.\n"
    result_msg: .asciiz "Resultado: "
    pi: .double 3.14159265359
    zero: .double	0.0
    two: .double	2.0
    one: .double	1.0
    degree: .double 180 #  (pi/180)
    
.text
.globl main
# Función para mostrar el menú
menu:
    #print_msg prompt     # Pedir ángulo por consola
    #read_float $f12      # Leer ángulo
    #print_newline        # Imprimir salto de línea    
    # Imprimir opciones del menú
    li $v0, 4
    la $a0, menuP
    syscall
       
    # Leer opción del usuario
    li $v0, 5
    syscall
    move $a0, $v0        # Guardar la opción en $a0
    # Saltar a la función correspondiente
    beq $a0, 1, mcua
    beq $a0, 2, sine
    beq $a0, 3, asin
    beq $a0, 4, sec
    beq $a0, 5, asec
    beq $a0, 6, linear_eq
    beq $a0, 7, exit
    j invalid_option
# Función para manejar opciones inválidas
invalid_option:
    li $v0, 4
    la $a0, invalid_msg
    syscall
    j menu    
# Función principal
main:
    j menu
exit:
    li $v0, 10        # Salir del programa
    syscall   

mcua:
    # Cï¿½digo para el Movimiento Circular Uniformemente Acelerado
    # ...

    # Devolver el resultado en $f0
    # ...
    jr $ra

# Funciï¿½n: Seno
sine:
	# Pedir angulo
    li $v0, 4
    la $a0, prompt
    syscall
       
    # Leer ángulo en $f0
    li $v0, 7
    syscall
    #b convertir_a_radianes
    l.d $f12, pi		#Cargar pi
    l.d $f8, degree 		# Cargar 180
    mul.d $f10, $f0, $f12	#angulo * pi
    div.d $f12, $f10, $f8  	# (angulo*pi) / 180.0
    
    
    # $f12 contiene el ángulo en radianes
    # $f0 contendrá el resultado
    
    l.d $f0, zero   # Inicializar el resultado en 0.0
    l.d $f2, one   # Inicializar el término actual en 1.0
    l.d $f4, one   # Inicializar el factorial en 1.0
    l.d $f6, one   # Inicializar el exponente en 1.0
    
    li $t0, 20      # Número de términos en la serie
    
seno_loop:
    div.d $f2, $f2, $f4  # x^n / n!
    mul.d $f2, $f2, $f12  # (x^n / n!) * angulo
    add.d $f0, $f0, $f2  # Sumar al resultado
    mul.d $f4, $f4, $f6  # Incrementar el factorial por 2
    add.d $f6, $f6, $f6  # Incrementar el exponente por 2
    
    subi $t0, $t0, 1     # Decrementar el contador de términos
    bnez $t0, seno_loop  # Si no hemos terminado, continuar
    
    j respuesta


respuesta:
	
	li $v0, 3        # Cargar el código de la llamada al sistema para imprimir un flotante
	syscall
	j menu
# Funciï¿½n: Seno inverso
    # x: $f12 (entrada), result: $f0 (salida)
asin:
    l.d $f0, zero        # Inicializar el resultado con x
    l.d $f2, one         # Inicializar el factorial en 1.0
    l.d $f4, one         # Inicializar el exponente en 1.0
    l.d $f6, one         # Inicializar el tï¿½rmino actual en 1.0
    
asin_loop:
    div.d $f4, $f4, $f2  # x^n / n!
    mul.d $f4, $f4, $f4  # (x^n / n!)^2
    mul.d $f0, $f0, $f4  # x * (x^n / n!)^2
    sub.d $f12, $f12, $f0 # Restar al resultado
    mul.d $f2, $f2, $f12 # n! *= x
    mul.d $f12, $f12, $f12 # x^2
    add.d $f4, $f4, $f4  # Incrementar el exponente por 2
    
    c.lt.s $f4, $f7      # Compara el tï¿½rmino actual con 0.0
    bc1t asin_end        # Si es menor, termina
    
    j asin_loop
    
asin_end:
    j respuesta

# Funciï¿½n: Secante
sec:
    l.d $f0, one         # Inicializar el resultado en 1.0
    l.d $f12, two        # Cargar x en $f12
    l.d $f2, one         # Inicializar el factorial en 1.0
    l.d $f4, one         # Inicializar el exponente en 1.0
    l.d $f6, one         # Inicializar el tï¿½rmino actual en 1.0
    
sec_loop:
    div.d $f6, $f6, $f2  # x^n / n!
    mul.d $f6, $f6, $f4  # (x^n / n!) * (2n-1)/(2n)
    add.d $f0, $f0, $f6  # Sumar al resultado
    mul.d $f2, $f2, $f12 # n! *= x
    mul.d $f12, $f12, $f12 # x^2
    add.d $f4, $f4, $f4  # Incrementar el exponente por 2
    
    c.lt.s $f6, $f7      # Compara el tï¿½rmino actual con 0.0
    bc1t sec_end         # Si es menor, termina
    
    
    j sec_loop
    
sec_end:
    j respuesta



# Funciï¿½n: Secante inversa
asec:
    l.d $f0, one         # Inicializar el resultado en 1.0
    l.d $f2, one         # Inicializar el factorial en 1.0
    l.d $f4, one         # Inicializar el exponente en 1.0
    l.d $f6, one         # Inicializar el tï¿½rmino actual en 1.0
    
asec_loop:
    div.d $f4, $f4, $f2  # x^n / n!
    mul.d $f4, $f4, $f4  # (x^n / n!)^2
    mul.d $f0, $f0, $f4  # x * (x^n / n!)^2
    sub.d $f12, $f12, $f0 # Restar al resultado
    mul.d $f2, $f2, $f12 # n! *= x
    mul.d $f12, $f12, $f12 # x^2
    add.d $f4, $f4, $f4  # Incrementar el exponente por 2
    
    c.lt.s $f4, $f7      # Compara el tï¿½rmino actual con 0.0
    bc1t asec_end        # Si es menor, termina
    
    
    j asec_loop
    
asec_end:
    j respuesta   
        
# Funciï¿½n: ax + b = y
linear_eq:
    # Cï¿½digo para resolver la ecuaciï¿½n ax + b = y
    # ...

    # Devolver el resultado en $f0
    # ...
    jr $ra                    
    
# Función para imprimir un mensaje
print_msg:
    li $v0, 4
    syscall
    jr $ra
    
    
    
    
# Función para leer un valor flotante desde la consola
read_float:
    li $v0, 6
    syscall
    jr $ra
    
# Función para imprimir un valor flotante
print_float:
    li $v0, 2
    syscall
    jr $ra




