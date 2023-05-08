import os
import csv
import pyodbc

# Set up the database connection
server = 'DESKTOP-4LJHQOE\SQLEXPRESS'
database = 'ProjectOneBikeStudy'
# username = '******'
# password = '******'
cnxn = pyodbc.connect(f"DRIVER={{SQL Server}};SERVER={server};DATABASE={database};")
# UID={username};PWD={password}
print(cnxn)

# Get the path to the folder containing the CSV files
folder_path = 'C:/Users/.../sets2'

# Loop over all the files in the folder
for filename in os.listdir(folder_path):
    # Check if the file is a CSV file
    if filename.endswith('.csv'):
        # Extract the table name from the filename
        table_name = filename[:-4]  # remove the '.csv' extension
        # Open the CSV file for reading
        with open(os.path.join(folder_path, filename), 'r') as csvfile:
            # Create a reader object
            reader = csv.reader(csvfile)
            # Get the header row (column names)
            header = next(reader)

            #have a datatype also inserted for each of the extracted and created columns:
            columns = []
            # just a debugging statement
            print("before column in header loop") 

            for column in header:
              print(column)
              stripped_column = column.replace(" ", "_")
              columns.append(f"{stripped_column} VARCHAR(255)")

            # Join the header row into a comma-separated string of column names
            print(columns)
            columns_str = ', '.join(columns)
            print(columns_str)
            # Create the SQL query to create the table & replace all the forbidden symbols

            create_query = f"CREATE TABLE [{table_name}] ({columns_str})"
            
            create_query = create_query.replace('-', '_')
            create_query = create_query.replace('/', '_')
            create_query = create_query.replace('»', '_')
            create_query = create_query.replace('¿', '_')
            create_query = create_query.replace('men\'s', 'mens')
            create_query = create_query.replace('women\'s', 'womens')
            create_query = create_query.replace('kid\'s', 'kids')
            
            # Execute the query
            print('executing the query now')
            cnxn.execute(create_query)
            # Loop over the remaining rows in the CSV file
            for row in reader:
                # Convert the row to a tuple of values
                for element in row:
                   element.replace("'", "_")
                   element.replace('kid\'s', 'kids')
                   element.replace('women\'s', 'womens')
                   element.replace('men\'s', 'mens')

                values = tuple(row)
                # Create the SQL query to insert the row into the table
                insert_query = f"INSERT INTO {table_name} VALUES {values}"
                # Execute the insert query
                cnxn.execute(insert_query)
                print('inserting values into a table...')
                
            print('inserting COMPLETE')
        # Commit the changes to the database
        cnxn.commit()
