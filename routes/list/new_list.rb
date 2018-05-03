post '/?' do
  user = User.first(id: session[:user_id])
  list = List.new_list params[:name], user
  errors = []
  errors << list.errors unless list.valid?

  if errors.empty?
    list.save
    list.add_permission(list.permissions[0])
  end

  all_lists = List.association_join(:permissions).where(user_id: user.id)
  slim :lists, locals: { lists: all_lists, errors: errors }
end
