post '/list/:id/new_comment/?' do
  user = User.first(id: session[:user_id])
  list = List.first(id: params[:id])
  comment = Comment.new(text: params[:text], user: user, list: list)
  errors = []

  # valid Comment
  errors << comment.errors unless comment.valid?

  comment.save if errors.empty?

  error_id = -2

  items = list.items_dataset.order(Sequel.desc(:starred)).all
  slim :list, locals: { list: list, items: items, errors: errors, error_id: error_id, user: user }
end
