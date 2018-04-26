get '/login/?' do
  if session[:user_id].nil?
    slim :login
  else
    slim :error, locals: {error: 'Please log out first'}
  end
end

post '/login/?' do
  md5sum = Digest::MD5.hexdigest params[:password]
  user = User.first(name: params[:name], password: md5sum)
  if user.nil?
    slim :error, locals: {error: 'Invalid login credentials'}
  else
    session[:user_id] = user.id
    redirect '/'
  end
end