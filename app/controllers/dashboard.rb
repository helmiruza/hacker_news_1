enable :sessions

post '/dashboard/:username/post/create' do |username|

	if session[:username] != nil

		cur_user = User.find_by(username: session[:username])
		@post = cur_user.posts.create(params[:post])

		redirect to "/post/#{@post[:id]}"
	else
	end
end

get '/post/:id' do |id|
	session[:post_id] = id
	@posts = Post.all
	@post = Post.find_by(id: id)

	@comments = Comment.where(post_id: id)
	erb :post
end

get '/edit/:id' do |id|
	@post = Post.find_by(id: id)
	erb :post_edit
end

post '/edit/:id' do |id|
	if session[:user_id] != nil
		@post = Post.find_by(id: id)
		@post.title = params[:post][:title]
		@post.post = params[:post][:post]
		@post.save
	end

	redirect to "/dashboard/#{session[:user_id]}"
end

post "/delete/:id" do |id|
	if session[:user_id] != nil
		@post = Post.find_by(id: id)
		@post.destroy
	end

	redirect to "/dashboard/#{session[:user_id]}"
end

post "/post/:id/comment" do |id|
	if session[:username] != nil
		cur_user = User.find_by(username: session[:username])
		@comment = cur_user.comments.create(text: params[:comment][:text],post_id: id)

		redirect to "/post/#{session[:post_id]}"
	else
		@errors = ["You must be logged in to comment"]
	end
end