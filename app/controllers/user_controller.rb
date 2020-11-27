class UserController < ApplicationController

  get '/login' do
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

  get '/signup' do
    if !is_logged_in?(session)
      erb :'/users/new'
    else
      redirect '/posts'
    end
  end

  post '/signup' do
    if params.none? {|k, v| v == ""}
      user = User.create(username: params[:username], learn_handle: params[:learn_handle], user_photo: params[:user_photo], password: params[:password])
      session[:user_id] = user.id
      flash[:success] = "Created successfully!"
      redirect '/posts'
    else
      flash[:error] = "Unsuccessfully created."
      redirect '/signup'
    end
  
    get '/logout' do
      session.clear
      flash[:success] = "See you next time!"
      redirect '/login'
    end

    get '/users/:id' do
      @user = User.find_by_id(params[:id])
      if @user && @user == current_user
        erb :'/users/users'
      else
        redirect '/signup'
      end
    end
  end