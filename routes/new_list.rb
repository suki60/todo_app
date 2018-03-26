get '/new/?' do
  haml :new_list
end

post '/new/?' do
  user = User.first(name: session[:user_id])
  List.new_list params[:title], params[:items], user
  redirect request.referer
end
