require 'sinatra/base'

class BattleShips < Sinatra::Base

	set :views, './views/'

  get '/' do
    erb :index
  end

  get '/new_game' do # GET /new_game HTTP/1.1
    erb :new_game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
