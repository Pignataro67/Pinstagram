class UserController < ApplicationController

  get '/users/:slug' do
    # "user's profile"
    @user = User.find_by_slug(params[:slug])
    erb :'/users/users'
  end

    get '/login' do
      # "Sign up"
      if !is_logged_in?(session)
        erb :'/users/login'
      else
        redirect '/posts'
      end
    end
  
    post '/login' do
      user = User.find_by(username: params[:username])
      
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/posts'
      else
        flash[:error] = "Your login information seems to be incorrect."
        redirect '/login'
      end
  end