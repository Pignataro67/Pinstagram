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
end