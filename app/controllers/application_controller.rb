class ApplicationController < ActionController::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  enable :sessions
    set :session_secret, 'finstagram_mek'
  get "/" do
    erb :welcome	
    "welcome to finstagram"
  end    
end