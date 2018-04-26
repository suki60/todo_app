get '/list/:id/?' do
  list = List.first(id: params[:id])
  errors = []
  id = -2
  slim :list, locals: {list: list, errors: errors, id: id}
end

post '/list/:id/?' do
  list = List.first(id: params[:id])
  user = User.first(id: session[:user_id])
  item = Item.new(name: params[:name], description: params[:description], user: user)
  item.valid?
  list.add_item(item) if item.errors.empty?
  item.errors.empty? ? id = -2 : id = -1
  slim :list, locals: {list: list, errors: item.errors, id: id}
end
