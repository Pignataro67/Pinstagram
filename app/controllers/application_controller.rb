class ApplicationController < ActionController::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'finstagram_mek'
    use Rack::Flash
  end

  get '/' do
    erb :index	
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end
  
    def is_logged_in?!!current_user
    end
  end  
end