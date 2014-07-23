require 'sinatra/base'
require_relative 'player'
require_relative 'board'
require_relative 'coordinates'
require_relative 'ship'
require_relative 'water'
require_relative 'cell'
require_relative 'game'

class BattleShips < Sinatra::Base

	set :session_secret, 'Marco'
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
	  	session[:player1] = Player.new(name: params[:player1_name], board: Board.new(content: Water.new))
      GAME.add(session[:player1])
	  	if GAME.start?
        redirect to('/game')
      else
        redirect to('/waiting_room')
      end
  end

  get '/waiting_room' do
    if GAME.start?
      @opponent = GAME.return_opponent(session[:player1])
      redirect to('/game')
    else
      erb :waiting_room
    end
  end

  get '/game' do
	  @board = session[:player1].board.render_display
    @opponent = GAME.return_opponent(session[:player1])
    @opponent_board = @opponent.board.render_display
  	erb :game
  end

  get '/place_ships' do
    @coordinates = Coordinates.new(params.values)
    @opponent = GAME.return_opponent(session[:player1])
    if @coordinates.valid? && !params.values.include?(nil)
      session[:player1].board.place(session[:player1].ships_to_deploy.pop, @coordinates)
      @board = session[:player1].board.render_display
      @opponent_board = @opponent.board.render_display
      erb :game
    else
      @board = session[:player1].board.render_display
      @opponent_board = @opponent.board.render_display
      erb :game
    end
  end
  
  post '/shoot_at' do
    @opponent = GAME.return_opponent(session[:player1])
    session[:player1].shoot_at(@opponent.board, params[:coordinate] )
    @board = session[:player1].board.render_display
    @opponent_board = @opponent.board.render_display
    erb :game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
