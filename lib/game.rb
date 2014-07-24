require './files'

class Game

	attr_accessor :players

	def initialize
		@players = []
	end

	def add(player)
		@players << player
	end

	def start?
		@players.count == 2
	end

	def return_opponent(player)
		@players.reject { |other_player| other_player.name == player.name || other_player.object_id == player.object_id }.first
	end

	def return(player_name)
		@players.select { |stored_player| stored_player.name == player_name }.first
	end

	def has_ships_floating?
		players.each { |player| player.board.grid.values.any?{|cell| cell.status == 'S'} }
	end

	def all_ships_deployed?
		@players.first.ships_to_deploy.count == 0 && @players.last.ships_to_deploy.count == 0 
	end

	def has_ships_floating?(player)
		player.board.grid.values.any?{|cell| cell.status == 'S'}
	end

end