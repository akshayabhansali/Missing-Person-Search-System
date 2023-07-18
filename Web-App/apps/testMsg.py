# from twilio.rest import Client

# account_sid = 'AC02eba941155f14b587867a0f0f765e92'
# auth_token = '0acdd8761156dbb42c1763fa071b6a34'
# client = Client(account_sid, auth_token)

# message = client.messages.create(
#   from_='whatsapp:+14155238886',
#   body='Your Yummy Cupcakes Company order of 1 dozen frosted cupcakes has shipped and should be delivered on July 10, 2019. Details: http://www.yummycupcakes.com/',
#   to='whatsapp:+918600761916'
# )

# print(message.sid)


# from twilio.rest import Client

# account_sid = 'AC02eba941155f14b587867a0f0f765e92'
# auth_token = '0acdd8761156dbb42c1763fa071b6a34'
# client = Client(account_sid, auth_token)

# message = client.messages.create(
#   from_='whatsapp:+14155238886',
#   body='Hi',
#   to='whatsapp:+918600761916'
# )

# print(message.sid)


# import smtplib
# from email.mime.text import MIMEText

# def send_email(subject, body, sender, recipients, password):
#     msg = MIMEText(body)
#     msg['Subject'] = subject
#     msg['From'] = sender
#     msg['To'] = ', '.join(recipients)
#     smtp_server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
#     smtp_server.login(sender, password)
#     smtp_server.sendmail(sender, recipients, msg.as_string())
#     smtp_server.quit()

# subject = "Email Subject"
# body = "This is the body of the text message"
# sender = "erenyaeger0711@gmail.com"
# recipients = ["rbhandare68@gmail.com"]
# password = "Pass@1234"

# send_email(subject, body, sender, recipients, password)

import yagmail

user = 'erenyaeger0711@gmail.com'
app_password = 'lddmhuvcbadaehfh' # a token for gmail
to = 'rbhandare68@gmail.com'

subject = 'test subject 1'
content = ['mail body content']

with yagmail.SMTP(user, app_password) as yag:
    yag.send(to, subject, content)
    print('Sent email successfully')

#lddmhuvcbadaehfh