class ApplicationController < ActionController::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  enable :sessions
    set :session_secret, 'finstagram_mek'
    use Rack::Flash
  get "/" do
    erb :welcome	
    "welcome to pinstagram"
    helpers do
      def current_user
        User.find(session[:user_id])
      end
  
      def is_logged_in?(session)
        session.has_key?(:user_id)
      end
    end  
end