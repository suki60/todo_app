get '/login/?' do
  if session[:user_id].nil?
    errors = ''
    slim :login, locals: { errors: errors }
  else
    redirect '/logout'
  end
end

post '/login/?' do
  md5sum = Digest::MD5.hexdigest params[:password]
  user = User.first(name: params[:name], password: md5sum)
  if user.nil?
    slim :login, locals: { errors: 'Incorrect username or password' }
  else
    session[:user_id] = user.id
    redirect '/'
  end
end
