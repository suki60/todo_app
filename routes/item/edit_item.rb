post '/list/:id/item/:item_id/?' do
  starred = params[:starred] == 'on'
  item = Item.new(name: params[:name], description: params[:description], due_date: params[:due_date])
  user = User.first(id: session[:user_id])

  if item.valid?
    item_from_db = Item.first(id: params[:item_id])
    item_from_db.update(name: item.name, description: item.description, starred: starred, due_date: item.due_date)
    error_id = 0
  else
    error_id = params[:item_id].to_i
  end

  list = List.first(id: params[:id])
  items = list.items_dataset.order(Sequel.desc(:starred)).all
  slim :list, locals: { list: list, items: items, errors: item.errors, error_id: error_id, user: user }
end
