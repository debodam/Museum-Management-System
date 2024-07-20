<<<<<<< Updated upstream:code/data_entry.py
from tablefuncs import insert, update, delete, lookup


def data_entry(cursor, cnx):
    print("Welcome to the data entry menu:")
    selection = input(
        "Please choose an option listed below:\n1- Insert\n2- Update\n3- Delete\n4- Lookup\n5- Exit\n"
    )
    if selection == "1":
        insert(cursor, cnx)
    elif selection == "2":
        update(cursor, cnx)
    elif selection == "3":
        delete(cursor, cnx)
    elif selection == "4":
        lookup(cursor)
    elif selection == "5":
        print("Exiting data entry menu")
        return
    else:
        print("Invalid selection")

    data_entry(cursor, cnx)
=======
# from tablefuncs import insert, update, delete


# def data_entry(cursor):
#     print("Welcome to the data entry menu:")
#     selection = input(
#         "Please choose an option listed below:\n1- Insert\n2- Update\n3- Delete\n4- Exit\n"
#     )
#     if selection == "1":
#         insert(cursor)
#     elif selection == "2":
#         update(cursor)
#     elif selection == "3":
#         delete(cursor)
#     elif selection == "4":
#         print("Exiting data entry menu")
#         return
#     else:
#         print("Invalid selection")

#     data_entry(cursor)
>>>>>>> Stashed changes:data_entry.py
