require 'sinatra/base'
require_relative 'player'
require_relative 'board'
require_relative 'coordinates'
require_relative 'ship'
require_relative 'water'

class BattleShips < Sinatra::Base

	set :views, './views/'

  get '/' do
    erb :index
  end

  get '/new_game' do # GET /new_game HTTP/1.1
    erb :new_game
  end

  post '/players' do
  	if params[:player1_name] == ""
  		redirect to("/new_game")
	  else
	  	@player1 = Player.new(name: params[:player1_name], board: Board.new)
	  	erb :players
	  end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
