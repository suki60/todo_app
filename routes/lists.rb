get '/?' do
  all_lists = List.all
  haml :lists, locals: {lists: all_lists}
end
