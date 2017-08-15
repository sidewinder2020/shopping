require_relative '../models/user.rb'
require_relative '../models/item.rb'

class ShoppingApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get '/' do
    erb :dashboard
  end

  get '/items' do
    @location = params[:location]
    @items = Item.find_by(params[:filter])
    erb :items_index
  end

  get '/items/new' do
    erb :new_item
  end

  post '/items' do
    item = Item.new(params)
    item.save
    redirect '/items'
  end

  delete '/items/:id' do
    Item.destroy(params[:id].to_i)
    redirect '/items'
  end

  get '/users' do
    @users = User.all
    erb :users_index
  end

  get '/users/new' do
    erb :new_user
  end

  post '/users' do
    user = User.new
    redirect '/users'
  end
end
