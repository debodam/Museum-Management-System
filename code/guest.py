from tablefuncs import *

def guest_view(cursor):
    selection = input("What do you wish to view?\n1- All Art Pieces\n2- Exhibitions\n3- Artists Featured\n4- Collections borrowed from\n5- Logout\n")

    if selection == "1":
        art_piece_menu(cursor)
    elif selection =="2":
        exhibition_menu(cursor)
    elif selection == "3":
        artist_menu(cursor)
    elif selection == "4":
        collection_menu(cursor)
    elif selection =="5":
        exit(1)
    else:
        print("Invalid selection")
        guest_view(cursor)

def art_piece_menu(cursor):
    selection = input("What kind of art piece do you wish to view?\n1- Paintings\n2- Statues and Sculptures\n3- Other\n4- Exit\n")
    if selection == "1":
        cursor.execute("SELECT ID_no, Artist, Year_created, Title FROM ART_OBJECT WHERE ID_no IN (SELECT ID_no FROM PAINTING);")
        show_table(cursor)
        subselect = input("Do you wish to view the descriptions of each of these peices?\n Yes/No\n")
        if subselect.lower() == "yes":
            cursor.execute("SELECT ID_no, AO_Description FROM ART_OBJECT WHERE ID_no IN (SELECT ID_no FROM PAINTING);")
            show_table(cursor)
            art_piece_menu(cursor)

        else:
            art_piece_menu(cursor)
    elif selection == "2":
        cursor.execute("SELECT ID_no, Artist, Year_created, Title FROM ART_OBJECT WHERE ID_no IN (SELECT ID_no FROM SCULPTURE_STATUE);")
        show_table(cursor)
        subselect = input("Do you wish to view the descriptions of each of these peices?\n Yes/No\n")
        if subselect.lower() == "yes":
            cursor.execute("SELECT ID_no, AO_Description FROM ART_OBJECT WHERE ID_no IN (SELECT ID_no FROM SCULPTURE_STATUE);")
            show_table(cursor)
            art_piece_menu(cursor)

        else:
            art_piece_menu(cursor)
    elif selection == "3":
        cursor.execute("SELECT ID_no, Artist, Year_created, Title FROM ART_OBJECT WHERE ID_no IN (SELECT ID_no FROM OTHER);")
        show_table(cursor)
        subselect = input("Do you wish to view the descriptions of each of these peices?\n Yes/No\n")
        if subselect.lower() == "yes":
            cursor.execute("SELECT ID_no, AO_Description FROM ART_OBJECT WHERE ID_no IN (SELECT ID_no FROM OTHER);")
            show_table(cursor)
            art_piece_menu(cursor)
        else:
            art_piece_menu(cursor)
    else:
        guest_view(cursor)



def exhibition_menu(cursor):
    cursor.execute("SELECT E_name FROM EXHIBITIONS")
    show_table(cursor)
    selection = input("Please enter the name of the exhibition you'd like to view:\n")
    print(selection,"'s information")
    cursor.execute(f"SELECT Start_Date, End_Date FROM EXHIBITIONS WHERE E_name = '{selection}'")
    show_table(cursor)
    subselect = input ('Would you like to view the pieces on display at the Exhibiton?\nYes/No\n')
    if subselect.lower() == "yes":
        cursor.execute(f"SELECT A.ID_no, A.Artist, A.Year_created, A.Title FROM EXHIBITPIECES EP JOIN ART_OBJECT A ON EP.ID_no = A.ID_no JOIN EXHIBITIONS E ON EP.E_Name = E.E_Name WHERE E.E_Name = '{selection}'")
        show_table(cursor)
        print('')
        guest_view(cursor)
    else:
        guest_view(cursor)


def artist_menu(cursor):    
    cursor.execute("SELECT A_name FROM ARTIST")
    show_table(cursor)
    selection = input("Please enter the name of the artist you'd like to view:\n")
    print(selection,"'s information")
    cursor.execute(f"SELECT A_name, Date_Born, Date_Died, Country_of_Origin FROM ARTIST WHERE A_name = '{selection}'")
    show_table(cursor)
    subselect = input(f"Would you like to view more information on {selection}'s style?\nYes/No\n")
    if subselect.lower() == "yes":
        cursor.execute(f"SELECT Country_of_Origin, Main_Style, Epoch, A_Description FROM ARTIST WHERE A_name = '{selection}'")
        show_table(cursor)
        info = input('Would you like to see more information on the Epoch?\nYes/No\n')
        if info.lower() == 'yes':
            cursor.execute(f"SELECT A.A_Name, A.Epoch, E.Ep_Description FROM ARTIST A JOIN EPOCH E ON A.Epoch = E.Ep_Type WHERE A.A_Name = '{selection}';")
            show_table(cursor)
        else:
            pass
        country = input(f"Would you like to view more information on '{selection}'s country of origin?\nYes/No\n")
        if country.lower() == 'yes':
            cursor.execute(f"SELECT A.A_Name, A.Country_of_Origin, C.Coun_Description FROM ARTIST A JOIN COUNTRYINFO C ON A.Country_of_Origin = C.Country WHERE A.A_Name = '{selection}';")
            show_table(cursor)
            guest_view(cursor)
        else:
            guest_view(cursor)
    else:
        guest_view(cursor)

def collection_menu(cursor):
    cursor.execute("SELECT C_name FROM COLLECTIONS")
    show_table(cursor)
    selection = input("Please enter the name of the collection you'd like to view:\n")
    cursor.execute(f"SELECT A.Title, A.Artist FROM ART_OBJECT A WHERE A.ID_no IN (SELECT ID_no FROM BORROWED B WHERE B.Collection_from = 'Department of Sculptures of the Middle Ages, Renaissance and Modern Times');")
    show_table(cursor)
    subselect = input('Would you like to view more information about this collection?\nYes/No\n')
    if subselect.lower() == 'yes':
        cursor.execute(f"SELECT C_Type, C_Description FROM COLLECTIONS WHERE C_Name = '{selection}'")
        show_table(cursor)
        cursor.execute(f"SELECT C_Address, Phone_num, Contact_person FROM COLLECTIONS WHERE C_Name = '{selection}'")
        show_table(cursor)
        guest_view(cursor)
    else:
        guest_view(cursor)

