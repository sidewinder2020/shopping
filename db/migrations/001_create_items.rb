require 'sqlite3'

database = SQLite3::Database.new("db/shopping_app_development.db")
database.execute("CREATE TABLE items (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                      name VARCHAR(64),
                                      description VARCHAR(64),
                                      price DECIMAL(10,5)
                                     );"  
                )
database.execute("insert into items (name, description, price) VALUES ('Phone', '2017 Apple iPhone 7', 600);")
database.execute("insert into items (name, description, price) VALUES ('TV', '2016 Samsung 55 inch UHD', 1499);")
database.execute("insert into items (name, description, price) VALUES ('Watch', '2017 Apple Watch Series 2', 379);")
database.execute("insert into items (name, description, price) VALUES ('Computer', '2016 Dell Inspiron 7000 Series', 999);")
database.execute("insert into items (name, description, price) VALUES ('Tablet', '2016 Apple iPad Mini', 395);")

puts "Items table created and seeded."
