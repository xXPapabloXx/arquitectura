import RPi.GPIO as GPIO
import time
GPIO.setmode(GPIO.BOARD)
GPIO.setup(12, GPIO.OUT)
GPIO.setup(16, GPIO.OUT)
GPIO.setup(18, GPIO.OUT)
GPIO.setup(22, GPIO.OUT)
delay = 0.25

while(True):
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
        
	
