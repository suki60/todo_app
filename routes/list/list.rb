get '/list/:id/?' do
  list = List.first(id: params[:id])
  user = User.first(id: session[:user_id])
  errors = []
  error_id = 0

  # order items to show them properly
  items = list.items_dataset.order(Sequel.desc(:starred)).all

  slim :list, locals: { list: list, items: items, errors: errors, error_id: error_id, user: user }
end
