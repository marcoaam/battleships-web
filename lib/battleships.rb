require 'sinatra/base'
require_relative 'player'
require_relative 'board'
require_relative 'coordinates'
require_relative 'ship'
require_relative 'water'
require_relative 'cell'

class BattleShips < Sinatra::Base

	set :session_secret, 'Marco'
	enable :sessions

	set :views, './views/'

  get '/' do
    erb :index
  end

  get '/new_game' do # GET /new_game HTTP/1.1
  	session[:player1] ||= nil
    erb :new_game
  end

  post '/players' do
  	if params[:player1_name] == ""
  		redirect to("/new_game")
	  else
	  	session[:player1] = Player.new(name: params[:player1_name], board: Board.new(content: Water.new))
	  	erb :players
	  end
  end

  get '/game' do
  	session[:player1].shoot_at(session[:player1].board, "A1")
	  session[:player1].shoot_at(session[:player1].board, "A2")
	  @board = session[:player1].board.render_display
  	erb :game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
