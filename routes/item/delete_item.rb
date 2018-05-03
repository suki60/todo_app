get '/delete/:id/item/:item_id/?' do
  list = List.first(id: params[:id])
  item = Item.first(id: params[:item_id])
  item.delete
  redirect '/list/' + list.id.to_s
end
