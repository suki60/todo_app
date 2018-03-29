get '/login/?' do

  if session[:user_id].nil?
    haml :login
  else
    haml :error, locals: {error: 'Please log out first'}
  end
end

post '/login/?' do
  md5sum = Digest::MD5.hexdigest params[:password]
  user = User.first(name: params[:name], password: md5sum)
  #binding.pry
  if user.nil?
    haml :error, locals: {error: 'Invalid login credentials'}
  else
    session[:user_id] = user.id
    redirect '/'
  end
end
