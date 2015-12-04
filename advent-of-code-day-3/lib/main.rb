class Grid
  def initialize
    @remembered_deliveries = Hash.new(0)
  end
  
  def visit!(coord)
    @remembered_deliveries[coord] += 1
  end
  
  def visited_coords
    @remembered_deliveries.select { |coords, count| count > 0 }.keys
  end
end

module Movement
  class << self
    # coordinate system is Cartesian [x, y]
    CHAR_VECTORS = Hash.new{[0, 0]}.merge({
      '^' => [0, 1],
      '>' => [1, 0],
      'v' => [0, -1],
      '<' => [-1, 0],
    })
    
    def moved_coord(direction_char, current_coords)
      add_vector(current_coords, CHAR_VECTORS[direction_char])
    end
    
    def add_vector(coords, vector)
      coords.zip(vector).map{|coord, change| coord + change}
    end
  end
end

module SantaTravel
  class << self
    def grid_from_following_directions(directions)
      location = [0, 0]
      grid = Grid.new
      grid.visit!(location)
      
      directions.each_char do |direction_char|
        location = Movement.moved_coord(direction_char, location)
        grid.visit!(location)
      end
      
      grid
    end
    
    def grid_from_two_santas_following_directions(directions)
      santa_locations = [[0, 0], [0, 0]]
      grid = Grid.new
      santa_locations.each do |location|
        grid.visit!(location)
      end
      curr_santa_index = 0
      
      directions.each_char do |direction_char|
        current_location = santa_locations[curr_santa_index]
        new_location = Movement.moved_coord(direction_char, current_location)
        grid.visit!(new_location)
        
        santa_locations[curr_santa_index] = new_location
        curr_santa_index = (curr_santa_index + 1) % santa_locations.size
      end
      
      grid
    end
  end
end


if __FILE__ == $0
  directions = gets.chomp
  #grid = SantaTravel.grid_from_following_directions(directions)
  grid = SantaTravel.grid_from_two_santas_following_directions(directions)
  puts grid.visited_coords.size
end
