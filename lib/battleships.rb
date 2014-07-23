require 'sinatra/base'
require_relative 'player'
require_relative 'board'
require_relative 'coordinates'
require_relative 'ship'
require_relative 'water'
require_relative 'cell'
require_relative 'game'

class BattleShips < Sinatra::Base

	enable :sessions
	set :views, './views/'
  set :public_dir, './public/'

  GAME = Game.new

  get '/' do
    erb :index
  end

  get '/new_game' do # GET /new_game HTTP/1.1
    erb :new_game
  end

  post '/players' do
	  	session[:player_name] = params[:player1_name]
      GAME.add(Player.new(name: session[:player_name], board: Board.new(content: Water.new)))
	  	if GAME.start?
        redirect to('/game')
      else
        redirect to('/waiting_room')
      end
  end

  get '/waiting_room' do
    if GAME.start?
      redirect to('/game')
    else
      erb :waiting_room
    end
  end

  get '/game' do
    @player = GAME.return(session[:player_name])
	  @board = @player.board.render_display
    @opponent = GAME.return_opponent(@player)
    @opponent_board = @opponent.board.render_display
  	erb :game
  end

  get '/place_ships' do
    @coordinates = Coordinates.new(params.values)
    @player = GAME.return(session[:player_name])
    @opponent = GAME.return_opponent(@player)
    if @coordinates.valid? && !params.values.include?(nil)
      @player.board.place(@player.ships_to_deploy.pop, @coordinates)
      @board = @player.board.render_display
      @opponent_board = @opponent.board.render_display
      erb :game
    else
      @board = @player.board.render_display
      @opponent_board = @opponent.board.render_display
      erb :game
    end
  end
  
  post '/shoot_at' do
    @player = GAME.return(session[:player_name])
    @opponent = GAME.return_opponent(@player)
    @player.shoot_at(@opponent.board, params[:coordinate] )
    @board = @player.board.render_display
    @opponent_board = @opponent.board.render_display
    erb :game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
