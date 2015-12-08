class OnOffLightGrid
  def initialize(side_length)
    @grid = RectangularRangeChangableGrid.new(side_length, false)
  end
  
  def count_of_lit_lights
    @grid.rows.reduce(0) do |count, row|
      count + row.count { |light_on| light_on }
    end
  end
  
  def turn_on!(start_coord, end_coord)
    @grid.change_range!(start_coord, end_coord) { true }
  end
  
  def turn_off!(start_coord, end_coord)
    @grid.change_range!(start_coord, end_coord) { false }
  end
  
  def toggle!(start_coord, end_coord)
    @grid.change_range!(start_coord, end_coord) { |light_on| !light_on }
  end
end

class BrightnessLightGrid
  def initialize(side_length)
    @grid = RectangularRangeChangableGrid.new(side_length, 0)
  end
  
  def total_brightness
    @grid.rows.reduce(0) do |sum, row|
      sum + row.reduce(0) do |row_sum, brightness|
        row_sum + brightness
      end
    end
  end
  
  def increase_brightness!(start_coord, end_coord, by_amount)
    @grid.change_range!(start_coord, end_coord) do |brightness|
      brightness + by_amount
    end
  end
  
  def decrease_brightness!(start_coord, end_coord, by_amount)
    @grid.change_range!(start_coord, end_coord) do |brightness|
      [brightness - by_amount, MIN_BRIGHTNESS].max
    end
  end
  
  private
  
  MIN_BRIGHTNESS = 0
end

class RectangularRangeChangableGrid
  def initialize(side_length, default_value)
    @grid = (0...side_length).map { (0...side_length).map { default_value } }
  end
  
  # Rows is an Array of rows. Each row is an Array of values.
  def rows
    @grid
  end
  
  def change_range!(start_coord, end_coord)
    start_col, start_row = start_coord
    end_col, end_row = end_coord
    (start_col..end_col).each do |col|
      (start_row..end_row).each do |row|
        rows[row][col] = yield rows[row][col] 
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


class OnOffInstructionsExecutor
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

class BrightnessInstructionsExecutor
  def initialize(light_grid)
    @light_grid = light_grid
  end
  
  def execute!(parsed_instructions)
    parsed_instructions.each do |name, start_coord, end_coord|
      case name
      when :turn_on
        @light_grid.increase_brightness! start_coord, end_coord, 1
      when :toggle
        @light_grid.increase_brightness! start_coord, end_coord, 2
      when :turn_off
        @light_grid.decrease_brightness! start_coord, end_coord, 1
      end
    end
    return nil
  end
end


if __FILE__ == $0
  VERSION_TO_RUN = 1 # put 0 for part 1, 1 for part 2
  light_grid_type = [OnOffLightGrid, BrightnessLightGrid][VERSION_TO_RUN]
  executor_type = [OnOffInstructionsExecutor, BrightnessInstructionsExecutor][VERSION_TO_RUN]
  result_method_name = [:count_of_lit_lights, :total_brightness][VERSION_TO_RUN]
  
  light_grid = light_grid_type.new(1000)
  parsed_instructions = InstructionsParser.new(STDIN)
  executor = executor_type.new(light_grid)
  executor.execute!(parsed_instructions)
  puts light_grid.send(result_method_name)
end
