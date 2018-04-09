get '/?' do
  #binding.pry
  user = User.first(id: session[:user_id])
  all_lists = List.association_join(:permissions).where(user_id: user.id)
  haml :lists, locals: {lists: all_lists}
end
