require 'sqlite3'

database = SQLite3::Database.new("db/shopping_app_development.db")
database.execute("CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                      name VARCHAR(64),
                                      email VARCHAR(64)
                                     );"  
                )
puts "Users table created."

