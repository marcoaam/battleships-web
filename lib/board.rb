require './lib/cell'

class Board

	def initialize(content: :water)
		@grid = create_new_grid_with(content)
	end

	def grid
		@grid
	end

	def place(ship_type, at_coordinates)
		at_coordinates.locations.each do |location|
			grid[location].content = ship_type
		end
	end

	def render_display
		rows_of_cells.each_slice(10).map { |el| el }
	end

	def nice_display
		render_display.each{|row| p row}
	end

	def get_coordinates_for(ship, coordinate, running)
		if running == 'horizontal'
			horizontal(ship, coordinate)
		else
			vertical(ship, coordinate)
		end
	end

	def vertical(ship, coordinate)
		coordinate_letter, coordinate_number = coordinate.chars.first, coordinate.chars.last
		(0...ship.remaining_hits).map { |number| (coordinate_letter.bytes.first + number).chr + coordinate_number }
	end

	def horizontal(ship, coordinate)
		coordinate_letter, coordinate_number = coordinate.chars.first, coordinate.chars.last.to_i
		(0...ship.remaining_hits).map { |number| coordinate_letter + (coordinate_number + number).to_s }
	end

	private

	def rows_of_cells
		grid.values.map{|cell| cell}
	end
	
	def create_new_grid_with(content)
		("A".."J").map { |letter| (1..10).map { |number| {"#{letter}#{number}" => Cell.new(content) } } }.flatten.inject(&:merge)
	end

end