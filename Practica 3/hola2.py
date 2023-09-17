import RPi.GPIO as GPIO
import time
GPIO.setmode(GPIO.BOARD)
GPIO.setup(12, GPIO.OUT)
GPIO.setup(16, GPIO.OUT)
GPIO.setup(18, GPIO.OUT)
GPIO.setup(22, GPIO.OUT)
delay = 0.25

def menu():
    print("Seleccione patron:")
    print("1")
    print("2")
    print("3")
    print("4")
    print("5 - Salir")
    
def patron1():
    #Patron 1
    for i in range(0,3):        
        GPIO.output(12,True)
        time.sleep(delay)
        GPIO.output(12,False)
        time.sleep(delay)
        GPIO.output(16,True)
        time.sleep(delay)
        GPIO.output(16,False)
        time.sleep(delay)
        GPIO.output(18,True)
        time.sleep(delay)
        GPIO.output(18,False)
        time.sleep(delay)
        GPIO.output(22,True)
        time.sleep(delay)
        GPIO.output(22,False)
        time.sleep(delay)
def patron2():
    #Patron 2
    for i in range(0,3):        
        GPIO.output(12,True)
        GPIO.output(16,True)
        time.sleep(delay)
        GPIO.output(12,False)
        GPIO.output(16,False)
        time.sleep(delay)
        GPIO.output(16,True)
        GPIO.output(18,True)
        time.sleep(delay)
        GPIO.output(16,False)
        GPIO.output(18,False)
        time.sleep(delay)
        GPIO.output(18,True)
        GPIO.output(22,True)
        time.sleep(delay)
        GPIO.output(18,False)
        GPIO.output(22,False)
        time.sleep(delay)
        GPIO.output(22,True)
        GPIO.output(12,True)
        time.sleep(delay)
        GPIO.output(22,False)
        GPIO.output(12,False)
        time.sleep(delay)
def patron3():
    #Patron 3
    for i in range(0,3):        
        GPIO.output(12,True)
        GPIO.output(22,True)
        time.sleep(delay)
        GPIO.output(12,False)
        GPIO.output(22,False)
        time.sleep(delay)
        GPIO.output(16,True)
        GPIO.output(18,True)
        time.sleep(delay)
        GPIO.output(16,False)
        GPIO.output(18,False)
        time.sleep(delay)
def patron4():
    #Patron 4
    for i in range(0,3):        
        GPIO.output(12,True)
        time.sleep(delay)
        GPIO.output(12,False)
        time.sleep(delay)
        GPIO.output(18,True)
        time.sleep(delay)
        GPIO.output(18,False)
        time.sleep(delay)
        GPIO.output(16,True)
        time.sleep(delay)
        GPIO.output(16,False)
        time.sleep(delay)        
        GPIO.output(22,True)
        time.sleep(delay)
        GPIO.output(22,False)
        time.sleep(delay)
    

while(True):
    menu()
    valor = int(input("Seleccione valor ->  "))
    if valor == 1:
        patron1()
    elif valor == 2:
        patron2()
    elif valor == 3:
        patron3()
    elif valor == 4:
        patron4()
    elif valor == 5:
        print("")
        break
    
    
    
        
        
    
        

