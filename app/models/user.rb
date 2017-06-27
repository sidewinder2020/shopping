require 'sqlite3'

class User
  attr_reader :name, :email, :id

  def initialize(user_params)
    @email       = user_params["email"]
    @name        = user_params["name"]
    @id          = user_params["id"] if user_params["id"]
    @database    = SQLite3::Database.new('db/shopping_app_development.db')
    @database.results_as_hash = true
  end

  def save
    @database.execute("INSERT INTO users (name, email) VALUES (?, ?);", @name, @email)
  end

  def self.all
    database = SQLite3::Database.new('db/shopping_app_development.db')
    database.results_as_hash = true
    users = database.execute("SELECT * FROM users")
    users.map do |item|
      User.new(item)
    end
  end

  def self.find(id)
    database = SQLite3::Database.new('db/shopping_app_development.db')
    database.results_as_hash = true
    item = database.execute("SELECT * FROM users WHERE id = ?", id).first
    User.new(item)
  end

  def self.update(id, user_params)
    database.execute("UPDATE users
                      SET name = ?,
                          email = ?
                      WHERE id = ?;",
                      user_params[:name],
                      user_params[:email],
                      id)

    User.find(id)
  end

  def self.destroy(id)
    database.execute("DELETE FROM users
                      WHERE id = ?;", id)
  end

  def self.database
    database = SQLite3::Database.new('db/shopping_app_development.db')
    database.results_as_hash = true
    database
  end
end
