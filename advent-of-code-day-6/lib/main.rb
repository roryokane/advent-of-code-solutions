class LightGrid
  def initialize(side_length)
    @grid = (0...side_length).map { (0...side_length).map { false } }
  end
  
  def count_of_lit_lights
    @grid.reduce(0) do |count, row|
      count + row.count { |light_on| light_on }
    end
  end
  
  def turn_on!(start_coord, end_coord)
    change_range!(start_coord, end_coord) { true }
  end
  
  def turn_off!(start_coord, end_coord)
    change_range!(start_coord, end_coord) { false }
  end
  
  def toggle!(start_coord, end_coord)
    change_range!(start_coord, end_coord) { |light_on| !light_on }
  end
  
  private
  
  def change_range!(start_coord, end_coord)
    start_x, start_y = start_coord
    end_x, end_y = end_coord
    (start_x..end_x).each do |x|
      (start_y..end_y).each do |y|
        @grid[y][x] = yield @grid[y][x] 
      end
    end
  end
end

class InstructionsParser
  def initialize(instructions_reader)
    @instructions_reader = instructions_reader
  end
  
  include Enumerable
  def each
    while line = @instructions_reader.gets
      line = line.chomp
      yield parse_one_instruction(line)
    end
  end
  
  private
  
  INSTRUCTION_REGEX = /^(.+) (\d+,\d+) through (\d+,\d+)$/
  
  def parse_one_instruction(instruction)
    begin
      matches = INSTRUCTION_REGEX.match(instruction)
      return [
        parse_instruction_name(matches[1]),
        parse_coordinates(matches[2]),
        parse_coordinates(matches[3]),
      ]
    rescue
      raise ParseError.new, "improperly formatted instruction: ‘#{instruction}’"
    end
  end
  
  def parse_instruction_name(instruction_name)
    case instruction_name
    when "turn on" then :turn_on
    when "turn off" then :turn_off
    when "toggle" then :toggle
    else raise
    end
  end
  
  def parse_coordinates(coordinates)
    coordinates.split(',').map(&:to_i)
  end

  class ParseError < StandardError
  end
end

class InstructionsExecutor
  def initialize(light_grid)
    @light_grid = light_grid
  end
  
  def execute!(parsed_instructions)
    parsed_instructions.each do |name, start_coord, end_coord|
      method_name = grid_method_name_for_instruction(name)
      @light_grid.send(method_name, start_coord, end_coord)
    end
    return nil
  end
  
  private
  
  def grid_method_name_for_instruction(name)
    (name.to_s + "!").to_sym
  end
end


if __FILE__ == $0
  light_grid = LightGrid.new(1000)
  parsed_instructions = InstructionsParser.new(STDIN)
  executor = InstructionsExecutor.new(light_grid)
  executor.execute!(parsed_instructions)
  puts light_grid.count_of_lit_lights
end
