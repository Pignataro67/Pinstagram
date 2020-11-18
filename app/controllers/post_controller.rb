class PostController < ApplicationController

  get '/posts' do
    if is_logged_in?
      @posts = Post.all.sort_by {|post| post.id}.reverse
      erb :'/posts/posts'
    else
      flash[:error] = "Please log in"
      redirect '/login'
    end
  end
  
  get '/posts/new' do
    if is_logged_in?
      erb :'/posts/new'
    else
      flash[:error] = "Please log in"
      redirect '/login'
    end
  end
  
  post '/posts' do
    if is_logged_in?
      if params[:file] && params[:caption] != ""
        @post = Post.create(caption: params[:caption], user_id: current_user.id)
        @filename = params[:file][:filename]
        file = params[:file][:tempfile]
        File.open("./public/images/post/#{@filename}", 'wb') do |f|
          f.write(file.read)
        end
        @post.post_photo = @filename
        @post.save
        flash[:success] = "Post successfully made!"
        redirect '/posts'
      else
        flash[:error] = "Please make sure both fields are present."
        redirect '/posts/new'
      end
    else
      flash[:error] = "Please stop!!"
      redirect '/login'
    end
  end
  
  get '/posts/:id' do
    if is_logged_in?
      @post = Post.find_by_id(params[:id])
      erb :'/posts/id'
    else
      flash[:error] = "Please log in"
      redirect '/login'
    end
  end
  
  delete '/posts/:id/delete' do
    post = Post.find_by_id(params[:id])
    if is_logged_in? && post.user_id == current_user.id
      post.delete
      flash[:success] = "Post removed"
      redirect '/posts'
    else
      flash[:error] = "Please log in"
      redirect '/login'
    end
  end
end