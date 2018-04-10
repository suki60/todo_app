get '/signup/?' do

  if session[:user_id].nil?
    slim :signup
  else
    slim :error, locals: {error: 'Please log out first'}
  end
end

post '/signup/?' do

  md5sum = Digest::MD5.hexdigest params[:password]
  #binding.pry
  User.create(name: params[:name], password: md5sum)
  redirect '/login'
end
