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
    erb :'User/home'
  end

  # Login/Logout actions

  get '/signup' do
    erb :'/account/signup'
  end

  post "/signup" do
    @user = User.new(:username => params[:username], :password => params[:password])
    @user.save
    session[:user_id] = @user.id
    puts params
    redirect '/user/home'
  end

  get '/login' do 
    erb :"/account/login"
  end

  post '/login' do
    @user = User.find_by(:username => params[:username], :password_digest => params[:password])
    if @user
      session[:user_id] = user.id
      redirect '/user/home'
      puts params
    else
      redirect '/login'
    end
end

get "/logout" do
  session.clear
  redirect "/"
end
end
