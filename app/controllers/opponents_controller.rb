class OpponentsController < ApplicationController
    get '/opponents' do
        @opponents = Opponent.all
        erb :'/opponents/opponents'
    end

    get '/opponents/new' do
        erb :'opponents/new_opponent'
    end

    get '/opponents/:id' do
        @opponent = Opponent.find(params[:id])
        erb :'/opponents/data'
    end

    get '/opponents/:id/edit' do
        @opponent = Opponent.find(params[:id])
        if logged_in?
            if who_is_it(@opponent)
                erb :'/opponents/edit'
            else
                 redirect "user/#{current_user.id}"
            end
        else
            redirect '/'
        end
    end

    patch '/opponents/:id' do
        @opponent = Opponent.find(params[:id])
        if logged_in?
            @opponent.update(
                :gamertag => params[:gamertag],
                :game => params[:game],
                :bracket => params[:bracket],
                :characters => params[:characters],
                :score => params[:score]
            )
            redirect "/opponents/#{@opponent.id}"
        else
            redirect '/opponents'
        end
    end

    delete '/opponents/:id' do
        @opponent = Opponent.find(params[:id])
        @opponent.destroy
        redirect to '/opponents'
    end

    post '/opponents' do
        opponent = Opponent.new(
            :gamertag => params[:gamertag],
            :game => params[:game],
            :bracket => params[:bracket],
            :characters => params[:characters],
            :score => params[:score],
            :user_id => params[:user_id]
        )
        if opponent.save && filled_info(opponent)
            redirect '/opponents'
        else
            redirect '/opponents/new'
        end
    end
end