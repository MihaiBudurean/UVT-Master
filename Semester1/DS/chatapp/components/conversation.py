class Conversation:
    def __init__(self, participants):
        self.participants = participants
        self.messages = []

    def add_message(self, message):
        self.messages.append(message)

    def load_messages(self):
        print("All Messages:")
        for message in self.messages:
            print(message)