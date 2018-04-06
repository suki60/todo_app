get '/edit/:id/?' do
  list = List.first(id: params[:id])
  #binding.pry
  items = list.items
  can_edit = true

  if list.nil?
    can_edit = false
  elsif list.shared_with == 'public'
    user = User.first(id: session[:user_id])
    permission = Permission.first(list: list, user: user)
    if permission.nil? or permission.permission_level == 'read_only'
      can_edit = false
    end
  end

  if can_edit
    #binding.pry
    haml :edit_list, locals: {list: list, items: items}
  else
    haml :error, locals: {error: 'Invalid permissions'}
  end
end

post '/edit/?' do
  user = User.first(id: session[:user_id])
  items = params[:items]

  #convert items id to_i
  items.each do |item|
    item[:id] = item[:id].to_i
  end

  errors = List.edit_list params[:id], params[:name], items, user
  if errors.empty?
    redirect '/'
  else
    haml :error_edit, locals: {error: errors}
  end
end
