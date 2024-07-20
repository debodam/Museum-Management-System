# tablefuncs.py
import mysql.connector


def show_table(cursor):
    col_names = cursor.column_names
    rows = cursor.fetchall()
    print("Search found", len(rows), "Entries\n")
    # Print header
    for col_name in col_names:
        print("{:<30s}".format(col_name), end='')
    print()
    # Print separator
    print(30 * len(col_names) * '-')
    # Print rows
    for row in rows:
        for val in row:
            print("{:<30}".format(str(val)), end='')
        print()
    print()
    return cursor


def insert(cursor, cnx):
    print("\nThe currently tables in the database are:\n")
    cursor.execute("SHOW TABLES")
    tables = [table[0] for table in cursor.fetchall()]

    for table_name in tables:
        print(table_name, end="    ")

    table = input(
        "\n\nPlease input the table you would like to insert data into: ")

    print("\nThe attributes of the selected table are the following: \n")
    cursor.execute(f"DESCRIBE {table}")
    col_info = cursor.fetchall()

    for col in col_info:
        print(col[0], end="    ")

    print("\n\n")

    values = []
    for col in col_info:
        value = input(f"Please enter a value for {col[0]}: ")
        values.append(value)

    placeholders = ', '.join(['%s'] * len(col_info))
    columns = ', '.join([col[0] for col in col_info])

    insert_statement = f"INSERT INTO {table} ({columns}) VALUES ({placeholders})"

    try:
        cursor.execute(insert_statement, values)
        print("Your insert was successful!")
        cnx.commit()
    except mysql.connector.errors.IntegrityError:
        print("Foreign key restriction will not allow for insertion.")
    except mysql.connector.errors.ProgrammingError:
        print("Invalid SQL Syntax, cannot insert.")


def update(cursor, cnx):
    print("\nThe current tables in the database are:\n")
    cursor.execute("SHOW TABLES")
    tables = [table[0] for table in cursor.fetchall()]

    for table_name in tables:
        print(table_name, end="    ")

    table = input(
        "\n\nPlease input the table you would like to update data in: ")

    print("\nThe attributes of the selected table are the following: \n")
    cursor.execute(f"DESCRIBE {table}")
    col_info = cursor.fetchall()

    for col in col_info:
        print(col[0], end="    ")

    print("\n\n")

    update_att = input("Please input the attribute you would like to update: ")
    update_value = input(
        "Please input the value you would like to update to: ")

    where_att = input(
        "Please input the attribute to identify the row to update: ")
    where_value = input(
        f"Please input the value of {where_att} to identify the row: ")

    update_statement = f"UPDATE {table} SET {update_att} = %s WHERE {where_att} = %s"

    try:
        cursor.execute(update_statement, (update_value, where_value))
        print("Your update was successful!")
        cnx.commit()
    except mysql.connector.errors.IntegrityError:
        print("Foreign key restriction will not allow for update.")
    except mysql.connector.errors.ProgrammingError:
        print("Invalid SQL Syntax, cannot update.")


def delete(cursor, cnx):
    print("\nThe current tables in the database are:\n")
    cursor.execute("SHOW TABLES")
    tables = [table[0] for table in cursor.fetchall()]

    for table_name in tables:
        print(table_name, end="    ")

    table = input(
        "\n\nPlease input the table you would like to delete data from: ")

    print("\nThe attributes of the selected table are the following: \n")
    cursor.execute(f"DESCRIBE {table}")
    col_info = cursor.fetchall()

    for col in col_info:
        print(col[0], end="    ")

    del_att = input(
        "\n\nPlease enter the attribute you would like to delete from (if not applicable, press enter): ")

    cursor.execute(f"SELECT * FROM {table}")
    rows = cursor.fetchall()

    for row in rows:
        print(row)

    if del_att == "":
        print("Your results are: \n")
        try:
            cursor.execute(f"DELETE FROM {table}")
            cursor.execute(f"SELECT * FROM {table}")
            rows = cursor.fetchall()

            for row in rows:
                print(row)

            print("\nYour deletion was successful!")
            cnx.commit()
        except mysql.connector.errors.ProgrammingError:
            print("Invalid SQL Syntax, cannot delete")
        except mysql.connector.errors.IntegrityError:
            print("Foreign key restriction will not allow for deletion.")
    else:
        del_value = input(
            f"\nPlease enter the value you would like to delete in your selected attribute ({del_att}): ")
        print("Your results are: \n")
        try:
            cursor.execute(
                f"DELETE FROM {table} WHERE {del_att} = %s", (del_value,))
            cursor.execute(f"SELECT * FROM {table}")
            rows = cursor.fetchall()

            for row in rows:
                print(row)

            print("\nYour deletion was successful!")
            cnx.commit()
        except mysql.connector.errors.ProgrammingError:
            print("Invalid SQL Syntax, cannot delete")
        except mysql.connector.errors.IntegrityError:
            print("Foreign key restriction will not allow for deletion.")


def lookup(cursor):
    table = input("Enter the table name you want to look up: ")
    column = input(
        "Enter the column name to filter by (press Enter for all): ")
    value = input(f"Enter the value for {column} (press Enter for all): ")

    query = f"SELECT * FROM {table}"
    if column and value:
        query += f" WHERE {column} = '{value}'"

    cursor.execute(query)
    show_table(cursor)
