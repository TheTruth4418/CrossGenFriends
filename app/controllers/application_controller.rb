require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    set :public_folder, 'public'
    set :views, "app/views"
    enable :sessions
		set :session_secret, "password_security"
  end

  # Home screens

  get "/" do
    erb :home
  end

  get "/user/home" do
    @user = User.find(session[:user_id])
    erb :'user/home'
  end

  get '/error' do
    erb :error
  end
  
  helpers do 
    def logged_in?
        !!session[:user_id]
    end 

    def current_user
        @current_user ||= User.find_by_id(session[:user_id])
    end 

    def who_is_it(opponent)
      opponent.user == current_user
    end

    def redirect_if_not_logged_in
        flash[:message] = "Please log in before continuing!"
        redirect to '/signin' if !logged_in?
    end
    
end 


end
