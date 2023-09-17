.data
x_deg:      .float  45.0        # Input value for sin(x) in degrees
result:     .float  0.0         # Variable to store the result
term:       .float  0.0         # Variable to store current term
n:          .word   1           # Variable to store current term number
sign:       .word   1           # Variable to store sign of term
pi_approx:  .float  3.14159     # Approximation of pi

.text
.globl main

main:
    # Initialize registers
    li $t0, 0           # $t0 is i (loop counter)
    li $t3, 1           # $t3 is sign
    
    # Load x_deg into $f0 and convert to radians
    l.s $f0, x_deg
    l.s $f12, pi_approx
    mul.s $f0, $f0, $f12   # Multiply by pi/180 to convert degrees to radians

    # Initialize result to 0
    l.s $f2, result

    loop:
        # Calculate term: ((-1)^n * x^(2n+1)) / (2n+1)!
        li $t1, 2           # $t1 is 2 (constant for 2n)
        mul $t2, $t0, $t1    # $t2 = 2n
        addi $t2, $t2, 1     # $t2 = 2n + 1

        neg $t4, $t0         # $t4 = -x
        move $t5, $t2        # $t5 = 2n + 1

        # Calculate (-1)^n * x^(2n+1)
        pow $f1, $t4, $t5    # $f1 = (-1)^n * x^(2n+1)

        # Calculate (2n+1)!
        move $a0, $t2        # Pass 2n + 1 as an argument
        jal factorial        # Call factorial function
        l.s $f3, $f0         # $f3 = (2n+1)!

        # Calculate term
        div.s $f1, $f1, $f3  # $f1 = ((-1)^n * x^(2n+1)) / (2n+1)!
        
        # Update result
        add.s $f2, $f2, $f1    # result += term

        # Update sign for the next term
        mul $t3, $t3, -1      # sign *= -1

        # Check if we've reached the desired number of iterations (adjust 10 for more accuracy)
        li $t6, 10
        bge $t0, $t6, end
        
        # Continue loop
        addi $t0, $t0, 1       # i++
        j loop

    end:
        # Print the result
        li $v0, 2           # Load system call for printing float
        mov.s $f12, $f2     # Load the result into $f12
        syscall
        
        # Exit program
        li $v0, 10          # Load system call for exit
        syscall

# Function: factorial(n)
# Calculates factorial of n and returns it in $f0
factorial:
    li $v0, 1               # Initialize result to 1
    li $t1, 1               # Initialize loop counter to 1

    loop_factorial:
        mul $v0, $v0, $t1     # result *= counter
        addi $t1, $t1, 1      # counter++
        blt $t1, $a0, loop_factorial # if counter < n, continue loop
        jr $ra
