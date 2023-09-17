.data
prompt: .asciiz "\nElige una funci�n:\n1. Movimiento circular uniformemente acelerado\n2. Seno\n3. Seno inverso\n4. Secante\n5. Secante inversa\n6. ax + b = y\n7. Salir\n"
result: .asciiz "El resultado es: "
zero: .double	0.0
two: .double	2.0
one: .double	1.0

.text
.globl main

# Funci�n: Movimiento circular uniformemente acelerado
mcua:
    # C�digo para el Movimiento Circular Uniformemente Acelerado
    # ...

    # Devolver el resultado en $f0
    # ...
    j menu

# Funci�n: Seno
sine:
    l.d $f0, zero         # Inicializar el resultado en 0.0
    l.d $f12, two        # Cargar x en $f12
    l.d $f2, one         # Inicializar el factorial en 1.0
    l.d $f4, one         # Inicializar el exponente en 1.0
    l.d $f6, one         # Inicializar el t�rmino actual en 1.0
    
sine_loop:
    div.d $f6, $f6, $f2  # x^n / n!
    mul.d $f6, $f6, $f4  # (x^n / n!) * (-1)^n
    add.d $f0, $f0, $f6  # Sumar al resultado
    mul.d $f2, $f2, $f12 # n! *= x
    mul.d $f12, $f12, $f12 # x^2
    add.d $f4, $f4, $f4  # Incrementar el exponente por 2
    
    c.lt.s $f6, $f7      # Compara el t�rmino actual con 0.0
    bc1t sine_end        # Si es menor, termina  
    
    j sine_loop
    
sine_end:
    j respuesta

respuesta:
	mov.d $f12, $f0
	li $v0, 2        # Cargar el c�digo de la llamada al sistema para imprimir un flotante
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

# Funci�n del men�
menu:
    li $v0, 4         # Imprimir cadena
    la $a0, prompt    # Cargar direcci�n de la cadena prompt
    syscall

    li $v0, 5         # Leer entero
    syscall
    move $t0, $v0     # Guardar la opci�n elegida

    # Llamar a la funci�n correspondiente
    beq $t0, 1, mcua
    beq $t0, 2, sine
    beq $t0, 3, asin
    beq $t0, 4, sec
    beq $t0, 5, asec
    beq $t0, 6, linear_eq
    beq $t0, 7, exit   # Salir si se elige la opci�n 7
    j menu

exit:
    li $v0, 10        # Salir del programa
    syscall

main:
    j menu            # Llamar al men�

