import RPi.GPIO as GPIO
import time
GPIO.setmode(GPIO.BOARD)




pinesMostrar = [11,10,13,15,12,36,37,38]

for pin in pinesMostrar:
        GPIO.setup(pin, GPIO.OUT)
        
def resetear():
        for j in range(len(pinesMostrar)):
                        GPIO.output(pinesMostrar[j],False)
        
resetear()
        
delay = 0.25

def menu():
    print("Seleccione operación:")
    print("1. Suma")
    print("2.Multiplicación")
    print("3.División")
    print("4.Resta")
    print("5 - Salir")
    

def convertir(num):
        num=bin(num)[2:]
        
        return num
        
def prenderTodos():
        for i in range(0, 20):
                for j in range(len(pinesMostrar)):
                        GPIO.output(pinesMostrar[j],True)
                        time.sleep(delay)
                for j in range(len(pinesMostrar)):
                        GPIO.output(pinesMostrar[j],False)
                        time.sleep(delay)
                
                
def representar(valor):
        if len(valor)<8:                
                for j in range(8-len(valor)):
                        valor = '0' + valor
        print(valor)
                        
                
        for i in range(len(valor)):                
                if valor[i] == '1':
                                GPIO.output(pinesMostrar[i],True)
                               
                                
                        
                
                
                        
                                
        
menu()     
        
num1 = int(input("Ingrese numero 1--> "))
num2 = int(input("Ingrese numero 2--> "))

opcion = int(input("Opcion---> "))


if opcion == 1:
        res = (num1+num2)
        if res <= 255 and res > 0:          
                print(convertir(res))      
                representar(convertir(res))
        else:
                prenderTodos()
                
if opcion == 2:
        res = (num1*num2)
        if res <= 255 and res > 0:                
                representar(convertir(res))
        else:
                prenderTodos()
        
if opcion == 3:
        res = int(num1/num2)
        if res <= 255 and res > 0:                
                representar(convertir(res))
        else:
                prenderTodos()
if opcion == 4:
        res = abs(num1-num2)
        if res <= 255 and res > 0:                
                representar(convertir(res))
        else:
                prenderTodos()
        
        

    
    
        
        
    
        

