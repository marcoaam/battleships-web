require './files'

class Game

	attr_reader :players

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
		players.reject {|other_player| other_player == player}.first
	end

end