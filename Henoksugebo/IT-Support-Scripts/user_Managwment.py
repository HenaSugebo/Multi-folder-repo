
# Bulk User Management Script
# Bulk User Account Creation and Management
# author: Henok Sugebo Joffe

import csv
import os

def create_user(file):
    with open(file, newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            username = row['username']
            os.system(f"net user {username} /add")
            # Add logic to create user account using the provided information
            print(f"user {username} created successfully.")
        create_user('users.csv')
