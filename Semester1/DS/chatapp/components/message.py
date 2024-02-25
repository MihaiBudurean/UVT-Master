from datetime import datetime

class Message:
    def __init__(self, text, timestamp, sender, receiver):
        self.text = text
        self.timestamp = timestamp
        self.status = 'sent'  # Default status is 'sent'
        self.sender = sender
        self.receiver = receiver
    
    def __str__(self):
        return f'{self.sender.username}, {self.timestamp.strftime('%d %B %Y, %H:%M')}\n{self.text}'