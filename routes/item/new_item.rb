post '/list/:id/new_item/?' do
  list = List.first(id: params[:id])
  user = User.first(id: session[:user_id])
  starred = params[:starred] == 'on'
  item = Item.new(name: params[:name], description: params[:description], user: user, starred: starred,
                  due_date: params[:due_date])

  # item validated
  item.valid?
  list.add_item(item) if item.errors.empty?
  error_id = item.errors.empty? ? 0 : -1

  items = list.items_dataset.order(Sequel.desc(:starred)).all
  slim :list, locals: { list: list, items: items, errors: item.errors, error_id: error_id, user: user }
end
