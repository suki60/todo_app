get '/?' do
  user = User.first(id: session[:user_id])
  all_lists = List.association_join(:permissions).where(user_id: user.id)
  errors = []
  slim :lists, locals: { lists: all_lists, errors: errors }
end
