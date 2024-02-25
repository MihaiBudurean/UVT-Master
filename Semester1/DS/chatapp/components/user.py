import re

class User:
    user_list = []

    def __init__(self, username, password):
        self.username = username
        self.__password = password
        self.friends_list = []
        self.groups_list = []
        self.unread_messages = []
        User.user_list.append(self)

    def change_username(self, new_username):
        self.username = new_username
        print("Username changed to:", self.username)

    def change_password(self, new_password):
        self.__password = new_password
        print("Password changed")

    def get_password(self):
        return self.__password

    def add_friend(self, username):
        if username == self.username:
            print("You cannot add yourself as a friend.")
        elif username in self.friends_list:
            print(f"{username} is already in your friends list.")
        else:
            self.friends_list.append(username)
            print(f"{username} added to your friends list.")

    def remove_friend(self, username):
        if username in self.friends_list:
            self.friends_list.remove(username)
            print(f"{username} removed from your friends list.")
        else:
            print(f"{username} is not in your friends list.")

    def display_friendslist(self):
        print(f"Friends list for {self.username}:")
        for friend in self.friends_list:
            print(friend)

    def read_new_messages(self):
        print("New Messages:")
        for message in self.unread_messages:
            print(message)
            message.status = 'read'  # Update status to 'read' after displaying
        self.unread_messages = []

    @classmethod
    def create_account(cls):
        while True:
            username = input("Enter a username: ")
            if re.match("^[a-zA-Z][a-zA-Z0-9\.\-_]*$", username):
                break
            else:
                print("Invalid username! Username must start with a letter and can contain letters, digits, ., -, _")

        while True:
            password = input("Enter a password: ")
            if re.match("^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()\-=+_{}\[\]|;':\"<>,./?~])[A-Za-z\d!@#$%^&*()\-=+_{}\[\]|;':\"<>,./?~]{8,}$", password):
                break
            else:
                print("Invalid password! Password must have at least 8 characters, at least one uppercase letter, at least one digit, and at least one special character.")
        
        return cls(username, password)
    
    @classmethod
    def delete_account(cls, username):
        for user in cls.user_list:
            if user.username == username:
                confirmation = input(f"Do you really want to delete the account for {username}? Type 'yes' to confirm: ")
                if confirmation.lower() == 'yes':
                    cls.user_list.remove(user)
                    print(f"Account for {username} has been deleted.")
                    return
                else:
                    print("Deletion cancelled.")
                    return
        print(f"User {username} not found.")

    @classmethod
    def login(cls):
        username = input("Enter your username: ")
        password = input("Enter your password: ")
        for user in cls.user_list:
            if user.username == username and user.get_password() == password:
                print("Yes")
                return
        print("No")

# Example usage:
user1 = User.create_account()
user1.unread_messages.append("Hello there!")
user1.unread_messages.append("How are you?")
user1.read_new_messages()
