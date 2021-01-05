class UsersController < ApplicationController

    get '/signup' do
        erb :'/user/signup'
      end
    
    post "/signup" do
      user = User.new(:username => params[:username], :password => params[:password])
      if user.save && no_blank(user)         
         session[:user_id] = user.id
         redirect '/user/home'
       else
        redirect '/'
      end
    end
    
    get '/login' do 
      erb :"/user/login"
    end
    
    post '/login' do
      user = User.find_by(:username => params[:username])
          if user && user.authenticate(params[:password]) && no_blank(user)
          session[:user_id] = user.id
          redirect '/user/home'
        else
          redirect '/error'
        end
    end
    
    get "/logout" do
      session.clear
      redirect "/"
    end

    get "/user/home" do
      @user = User.find(session[:user_id])
      erb :'user/home'
    end

end