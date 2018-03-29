get '/new/?' do
  haml :new_list
end

post '/new/?' do
  user = User.first(id: session[:user_id])
  list = List.new_list params[:name], params[:items], user
  redirect '/'
end
