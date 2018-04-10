get '/edit/:id/?' do
  list = List.first(id: params[:id])
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
    slim :edit_list, locals: {list: list, items: list.items}
  else
    slim :error, locals: {error: 'Invalid permissions'}
  end
end

post '/edit/?' do
  user = User.first(id: session[:user_id])
  list = List.edit_list params[:id], params[:name], params[:items], user

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
    slim :error_edit_list, locals: {errors: errors, list: list, items: list.items}
  end
end
