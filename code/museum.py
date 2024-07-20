import mysql.connector
from admin import *
from data_entry import *
from guest import *


def main():

    print("Welcome to the Art Museum Database:")
    print("Please select your role from the list below:")
    print("1. Admin user")
    print("2. Data entry user")
    print("3. Guest user")
    print("4. Exit program")

    selection = input()

    if selection in ["1", "2"]:
        username = input("Please enter your username: ")
        passcode = input("Please enter your password: ")
    elif selection == "3":
        username = "guest"
        passcode = None
    else:
        print('Exiting program')
        exit(1)

    try:
        cnx = mysql.connector.connect(
            host="127.0.0.1",
            port=3306,
            user=username,
            password=passcode
        )
        cursor = cnx.cursor()
        cursor.execute("use artmuseum")

        if selection == "1":
            admin_console(cursor)
        elif selection == "2":
            data_entry(cursor, cnx)
        elif selection == "3":
            guest_view(cursor)
    except Exception as e:
        print('ERROR')
        print(e)

    cursor.close()
    cnx.close()


if __name__ == "__main__":
    main()
