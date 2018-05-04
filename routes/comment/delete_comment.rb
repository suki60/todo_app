get '/delete/:id/comment/:comment_id/?' do
  user = User.first(id: session[:user_id])
  list = List.first(id: params[:id])
  comment = Comment.first(id: params[:comment_id])
  comment.delete

  errors = []
  error_id = -2
  items = list.items_dataset.order(Sequel.desc(:starred)).all
  slim :list, locals: { list: list, items: items, errors: errors, error_id: error_id, user: user }
end
