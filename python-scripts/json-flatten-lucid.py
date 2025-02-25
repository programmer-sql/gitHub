json_data = '''{
  "OrderMaster": {
    "OrderID": "ORD001",
    "OrderDate": "2025-02-24",
    "Customer": {
      "CustomerID": "CUST001",
      "CustomerName": "John Doe",
      "CustomerEmail": "johndoe@example.com",
      "CustomerPhone": "123-456-7890",
      "Address": {
        "Street": "123 Main St",
        "City": "Anytown",
        "State": "NY",
        "PostalCode": "10001"
      }
    },
    "Employee": {
      "EmployeeID": "EMP001",
      "EmployeeName": "Jane Smith",
      "EmployeePosition": "Sales Representative",
      "EmployeePhone": "987-654-3210",
      "EmployeeEmail": "janesmith@example.com"
    },
    "OrderDetail": [
      {
        "OrderID": "ORD001",
        "ProductID": "PROD001",
        "Quantity": 2,
        "UnitPrice": 19.99,
        "LineTotal": 39.98
      },
      {
        "OrderID": "ORD001",
        "ProductID": "PROD002",
        "Quantity": 1,
        "UnitPrice": 35.50,
        "LineTotal": 35.50
      }
    ],
    "TotalAmount": 75.48
  },
  "Category": [
    {
      "CategoryID": "CAT001",
      "CategoryName": "Electronics",
      "Product": {
        "ProductID": "PROD001",
        "ProductName": "Smartphone",
        "UnitPrice": 19.99,
        "StockQuantity": 150
      }
    },
    {
      "CategoryID": "CAT002",
      "CategoryName": "Clothing",
      "Product": {
          "ProductID": "PROD002",
          "ProductName": "T-shirt",
          "CategoryID": "CAT002",
          "UnitPrice": 35.50,
          "StockQuantity": 200
        }
    }
  ]
}'''

import json
import csv
from collections import defaultdict

def get_column_datatypes(data, parent_key='', result=None):
    if result is None:
        result = {}

    if isinstance(data, dict):
        for key, value in data.items():
            new_key = f"{parent_key}.{key}" if parent_key else key
            get_column_datatypes(value, new_key, result)
    elif isinstance(data, list):
        if data:
            get_column_datatypes(data[0], parent_key, result)
        else:
            result[parent_key] = 'list'
    else:
        result[parent_key] = type(data).__name__
    return result

def json_to_table_columns(json_data, output_file):
    data = json.loads(json_data) if isinstance(json_data, str) else json_data
    columns_datatypes = get_column_datatypes(data)
    
    # Structure to hold tables and their columns
    tables = defaultdict(list)
    table_hierarchy = {}
    all_tables = []
    root_table = "base table"  # Changed from Default

    # Process each column to build table hierarchy
    for column_path, dtype in columns_datatypes.items():
        parts = column_path.split('.')
        current_table = root_table

        # Build table hierarchy
        for part in parts[:-1]:  # Process all parts except last as tables
            if part not in table_hierarchy:
                table_hierarchy[part] = current_table
            if part not in all_tables:
                all_tables.append(part)
            current_table = part  # Move down the hierarchy

        # Add column to the final table in hierarchy
        column_name = parts[-1]
        tables[current_table].append({
            'column': column_name,
            'dtype': dtype,
            'max_length': 'Multiple' if dtype == 'list' else 'N/A',
            'constraint': '',
            'fk_schema': '',
            'fk_table': '',
            'fk_column': ''
        })

    # Add relationship columns and constraints
    for table in [root_table] + all_tables:
        parent = table_hierarchy.get(table, None)
        is_root = table == root_table
        
        # Add relationship-column at first position
        tables[table].insert(0, {
            'column': 'relationship-column',  # Changed from Default
            'dtype': 'str',
            'max_length': 'N/A',
            'constraint': 'PRIMARY KEY' if is_root else 'FOREIGN KEY',
            'fk_schema': 'dbo' if not is_root else '',
            'fk_table': parent if parent else '',
            'fk_column': 'relationship-column' if not is_root else ''  # Changed reference
        })

    # Generate final rows
    final_rows = []
    processed_tables = [root_table] + sorted(all_tables, key=lambda x: x.lower())
    
    for table in processed_tables:
        ordinal = 1
        for col in tables[table]:
            fk_values = {
                'FOREIGN KEY_table_schema': col['fk_schema'] or 'NULL',
                'FOREIGN KEY_table_name': col['fk_table'] or 'NULL',
                'FOREIGN KEY_column_name': col['fk_column'] or 'NULL'
            }
            
            final_rows.append({
                'dbms': 'sqlserver',
                'table_catalog': 'def',
                'table_schema': 'dbo',
                'table_name': table,
                'column_name': col['column'],
                'ordinal_position': ordinal,
                'data_type': col['dtype'],
                'character_max_length': col['max_length'],
                'constraint_type': col['constraint'] or 'NULL',
                **fk_values
            })
            ordinal += 1

    # Write to CSV
    with open(output_file, 'w', newline='') as csvfile:
        fieldnames = [
            'dbms', 'table_catalog', 'table_schema', 'table_name',
            'column_name', 'ordinal_position', 'data_type',
            'character_max_length', 'constraint_type',
            'FOREIGN KEY_table_schema', 'FOREIGN KEY_table_name', 
            'FOREIGN KEY_column_name'
        ]
        
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(final_rows)

# Generate and print
json_to_table_columns(json_data, "lucid_output_file.csv")
