import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import RPi.GPIO as GPIO
import time
GPIO.setmode(GPIO.BOARD)
GPIO.setup(12, GPIO.IN)
GPIO.setup(16, GPIO.IN)
GPIO.setup(18, GPIO.IN)
delay = 0.5



smtp_server = 'mail.aplogistico.com'
smtp_port = 26
smtp_username = 'clase@aplogistico.com'
smtp_password = '*Unapiedra123*'



mensaje = MIMEMultipart()
mensaje['From'] = smtp_username
mensaje['To'] = 'clase@aplogistico.com'
mensaje['Subject'] = 'TEST'


def enviar():    
    try:
        with smtplib.SMTP(smtp_server, smtp_port) as servidor:
            servidor.starttls()  
            servidor.login(smtp_username, smtp_password)
            servidor.sendmail(smtp_username, 'juancho.carmona.13@gmail.com', mensaje.as_string())
        print("Correo enviado exitosamente")
    except Exception as e:
        print("Error al enviar el correo:", e)
        



while (True):
    if GPIO.input(16) == False:
        mensaje['Subject'] = 'Boton 1'
        enviar()
        time.sleep(delay)
        
    if GPIO.input(12) == False:
        mensaje['Subject'] = 'Boton 2'
        enviar()
        time.sleep(delay)

    if GPIO.input(18) == False:
        mensaje['Subject'] = 'Boton 3'
        enviar()
        time.sleep(delay)
