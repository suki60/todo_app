get '/logout/?' do
  session[:user_id] = nil
  redirect '/login'
end
