post '/list/:id/:item_id/?' do
  list = List.first(id: params[:id])
  user = User.first(id: session[:user_id])
  item = Item.new(name: params[:name], description: params[:description], user: user, list: list)

  if item.valid?
    item_from_db = Item.first(id: params[:item_id])
    item_from_db.update(name: item.name, description: item.description)
    id = -2
  else
    id = params[:item_id].to_i
  end

  slim :list, locals: { list: list, errors: item.errors, id: id }
end
