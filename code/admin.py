from tablefuncs import *


def admin_console(cursor):
    print("Welcome to the admin menu:")
    selection = input(
        "Please choose an option listed below:\n1- Query\n2- Select and Run SQL SCRIPT\n3- Manage Users\n4- Exit\n"
    )
    if selection == "1":
        query = input("Please input a query:\n")
        cursor.execute(query)
        show_table(cursor)
        admin_console(cursor)
    elif selection == "2":
        script_path = input("Please enter the path to the SQL script file: ")
        try:
            with open(script_path, "r") as script_file:
                script = script_file.read()
                cursor.execute(script)
                print("SQL script executed successfully.")
        except FileNotFoundError:
            print("File not found. Please enter a valid file path.")
        admin_console(cursor)
    elif selection == "3":
        print("Manage Users:")
        selection = input(
            "Please choose an option listed below:\n1- Add User\n2- Edit User\n3- Block User\n4- Show All Users\n5- Exit\n"
        )
    elif selection == "4":
        print("Exiting admin menu")
        return
    else:
        print("Invalid selection")
        admin_console(cursor)
    if selection == "1":
        username = input("Enter the username of the new user: ")
        role = input("Enter the role for the new user: ")
        password = input("Enter the password for the new user: ")
        cursor.execute(f"CREATE USER '{username}'@localhost IDENTIFIED BY '{password}'")

        cursor.execute(f"GRANT '{role}'@localhost TO '{username}'@localhost")
        admin_console(cursor)
    elif selection == "2":
        username = input("Enter the username of the user to edit: ")
        new_password = input("Enter the new password for the user: ")
        cursor.execute(f"SET PASSWORD FOR {username}@localhost = {new_password}")
        admin_console(cursor)
    elif selection == "3":
        username = input("Enter the username of the user to block: ")
        cursor.execute(f"DROP USER {username}@localhost")
        admin_console(cursor)
    elif selection == "4":
        show_all_users(cursor)
        admin_console(cursor)
    elif selection == "5":
        print("Exiting admin menu")
        return
    else:
        print("Invalid selection")
        admin_console(cursor)


def show_all_users(cursor):
    cursor.execute("SELECT user FROM mysql.user")
    users = cursor.fetchall()
    print("All Users:")
    for user in users:
        print(user[0])
