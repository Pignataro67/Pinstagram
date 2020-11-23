class UserController < ApplicationController

  get '/users/:slug' do
    # "user's profile"
    @user = User.find_by_slug(params[:slug])
    erb :'/users/users'
  end

    get '/signup' do
      # "Sign up"
      if !is_logged_in?(session)
        erb :'/users/new'
      else
        redirect '/posts'
      end
    end
  
    post '/signup' do
      @user = User.new(params[:user])
      @user.user_photo = ""
      session[:user_id] = @user.id
      @user.save
      if @user.save
        redirect '/posts'
      else
        flash[:error] = "Error"
        redirect '/signup'
      end
    end
  end