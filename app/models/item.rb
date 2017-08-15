require 'sqlite3'

class Item
  attr_reader :name, :description, :price, :id

  def initialize(item_params)
    @id          = item_params["id"] if item_params["id"]
    @name        = item_params["name"]
    @description = item_params["description"]
    @price       = item_params["price"]
    @database    = SQLite3::Database.new('db/shopping_app_development.db')
    @database.results_as_hash = true
  end

  def save
    @database.execute("INSERT INTO items (name, description, price) VALUES (?, ?, ?);", @name, @description, @price)
  end

  def self.all
    items = database.execute("SELECT * FROM items")
    items.map do |item|
      Item.new(item)
    end
  end

  def self.find(id)
    item = database.execute("SELECT * FROM items WHERE id = ?", id).first
    Item.new(item)
  end

  def self.update(id, item_params)
    database.execute("UPDATE items
                      SET name = ?,
                          description = ?,
                          price = ?
                      WHERE id = ?;",
                      item_params[:name],
                      item_params[:description],
                      item_params[:price].to_f,
                      id)

    Item.find(id)
  end

  def self.destroy(id)
    database.execute("DELETE FROM items
                      WHERE id = ?;", id)
  end

  def self.find_by(filter)
    items = database.execute("SELECT * FROM items
                              WHERE description LIKE ?;", "%#{filter}%")
    items.map do |item|
      Item.new(item)
    end
  end

  def self.database
    database = SQLite3::Database.new('db/shopping_app_development.db')
    database.results_as_hash = true
    database
  end
end
