post '/delete/?' do
  list = List.first(id: params[:id])
  list.items.each(&:delete)
  list.permissions.each(&:delete)
  list.delete
  redirect '/'
end
