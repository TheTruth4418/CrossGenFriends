require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    set :public_folder, 'public'
    set :views, "app/views"
    enable :sessions
		set :session_secret, "password_security"
  end

   get "/" do
    erb :home
  end

  get '/error' do
    erb :error
  end

  helpers do 
  # Checks the login
    def logged_in?
        !!session[:user_id]
    end 
  # Checks who the current user is
    def current_user
        @current_user ||= User.find_by_id(session[:user_id])
    end 
  # Helps make sure the opponent belongs to the user to enable the CRUD functions
    def who_is_it(opponent)
      opponent.user == current_user
    end
  # Validates there are no blanks in the forms for login
    def no_blank(user)
      user.username != "" && user.username != nil
      user.password_digest != "" && user.password_digest != nil
    end
  # Validates that all the fields are filled in
    def filled_info(opponent)
      opponent.gamertag != "" && opponent.game != "" && opponent.bracket != "" && opponent.characters != "" && opponent.score != ""
    end
    
end 


end
