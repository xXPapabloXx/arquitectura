import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

#Server y credenciales

smtp_server = 'mail.aplogistico.com'
smtp_port = 26
smtp_username = 'clase@aplogistico.com'
smtp_password = '*Unapiedra123*'


# Crear el objeto de mensaje
mensaje = MIMEMultipart()
mensaje['From'] = smtp_username
mensaje['To'] = 'juancho.carmona.13@gmail.com'
mensaje['Subject'] = 'TEST'

# Conexión al servidor SMTP y envío del correo
try:
    with smtplib.SMTP(smtp_server, smtp_port) as servidor:
        servidor.starttls()  # Iniciar cifrado TLS
        servidor.login(smtp_username, smtp_password)
        servidor.sendmail(smtp_username, 'juancho.carmona.13@gmail.com', mensaje.as_string())
    print("Correo enviado exitosamente")
except Exception as e:
    print("Error al enviar el correo:", e)

