get '/new/?' do
  slim :new_list
end

post '/new/?' do
  user = User.first(id: session[:user_id])
  list = List.new_list params[:name], params[:items], user

  #init errors array and validate list and items. We append errors if they are not valid
  errors = []
  errors << list.errors if !list.valid?
  list.items.each { |item| errors << item.errors if !item.valid? }

  if errors.empty?
    list.save
    list.items.each { |item| list.add_item(item) }
    list.add_permission(list.permissions[0])
    redirect '/'
  else
    slim :error_new_list, locals: {errors: errors}
  end
end
