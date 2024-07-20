def show_table(cursor):
    col_names = cursor.column_names
    rows = cursor.fetchall()
    print("Search found", len(rows), "Entries\n")
    # Print header
    for col_name in col_names:
        print("{:<30s}".format(col_name), end="")
    print()
    # Print separator
    print(30 * len(col_names) * "-")
    # Print rows
    for row in rows:
        for val in row:
            print("{:<30}".format(str(val)), end="")
        print()
    print()
    return cursor
