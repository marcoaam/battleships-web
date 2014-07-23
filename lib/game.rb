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

end