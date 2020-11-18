class ApplicationController < ActionController::Base
  get "/" do
    erb :welcome	
    "welcome to finstagram"
  end    
end