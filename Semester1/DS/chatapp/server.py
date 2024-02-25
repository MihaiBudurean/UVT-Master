import socket
import threading
import re
import firebase_admin
from firebase_admin import credentials, firestore

def create_account(client_socket):
    while True:
        username = input("Enter a username: ")
        if re.match("^[a-zA-Z][a-zA-Z0-9\.\-_]*$", username):
            break
        else:
            client_socket.sendall("Invalid username! Username must start with a letter and can contain letters, digits, ., -, _")

    while True:
        password = input("Enter a password: ")
        if re.match("^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()\-=+_{}\[\]|;':\"<>,./?~])[A-Za-z\d!@#$%^&*()\-=+_{}\[\]|;':\"<>,./?~]{8,}$", password):
            break
        else:
            client_socket.sendall("Invalid password! Password must have at least 8 characters, at least one uppercase letter, at least one digit, and at least one special character.")
    
    users_ref = db.collection('users').document(username)
    user_data = {
        'password': password,
        'friends_list': [],
        'groups_list': [],
    }
    users_ref.add(user_data)
    client_socket.sendall(f'User {username} with password {password} added succesfully!')


def login(client_socket):
    username = input("Enter a username: ")
    password = input("Enter a password: ")

    users_ref = db.collection('users')
    query = users_ref.where('username', '==', username).where('password', '==', password).limit(1)
    docs = query.stream()

    for doc in docs:
        global active_user
        active_user = doc.to_dict()
        client_socket.sendall(f'User {username} logged in succesfully!')
        return

    client_socket.sendall(f'User {username} not found!')


def delete_account(client_socket):
    users_ref = db.collection('users')
    query = users_ref.where('username', '==', active_user['username']).limit(1)
    docs = query.stream()

    for doc in docs:
        doc.reference.delete()
        client_socket.sendall(f'User {active_user['username']} removed succesfully!')
        active_user = ''
        return
    
    client_socket.sendall(f'User {active_user['username']} not found!')


def process_command(command, client_socket):
    if command == 'create account':
        create_account(client_socket)
    elif command == 'delete account':
        delete_account(client_socket)
    elif command == 'login':
        login(client_socket)
    elif command == 'add friend':
        # Execute add friend logic
        pass
    elif command == 'remove friend':
        # Execute remove friend logic
        pass
    elif command == 'show friends list':
        # Execute show friends list logic
        pass
    elif command == 'open conversation':
        # Execute open conversation logic
        pass
    elif command == 'close conversation':
        # Execute close conversation logic
        pass
    elif command == 'read new messages':
        # Execute read new messages logic
        pass
    elif command == 'exit':
        # Execute exit logic
        pass
    elif command == 'change username':
        # Execute change username logic
        pass
    elif command == 'change password':
        # Execute change password logic
        pass
    elif command == 'open group conversation':
        # Execute open group conversation logic
        pass
    elif command == 'close group conversation':
        # Execute close group conversation logic
        pass
    elif command == 'create group':
        # Execute create group logic
        pass
    elif command == 'close group':
        # Execute close group logic
        pass
    else:
        print("Unrecognized command:", command)

def handle_client(client_socket, client_address):
    print("Connection from", client_address)

    while True:
        data = client_socket.recv(1024).decode().strip()

        if not data:
            break

        process_command(data, client_socket)

    client_socket.close()
    print("Connection with", client_address, "closed")



cred = credentials.Certificate('credentials.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

SERVER_ADDRESS = '127.0.0.1'
SERVER_PORT = 12345
active_user = ''

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind((SERVER_ADDRESS, SERVER_PORT))
server_socket.listen(5)

print("Server is listening on", SERVER_ADDRESS, "port", SERVER_PORT)

while True:
    client_socket, client_address = server_socket.accept()

    client_thread = threading.Thread(target=handle_client, args=(client_socket, client_address))
    client_thread.start()
