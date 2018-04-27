get '/signup/?' do
  if session[:user_id].nil?
    slim :signup, locals: { errors: '' }
  else
    redirect '/logout'
    redirect '/signup'
  end
end

post '/signup/?' do
  md5sum = Digest::MD5.hexdigest params[:password]
  user = User.new(name: params[:name], password: md5sum)

  if user.valid?
    user.save
    slim :login, locals: { errors: '' }
  else
    slim :signup, locals: { errors: user.errors }
  end
end
