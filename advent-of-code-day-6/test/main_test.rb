require 'stringio'
require_relative 'test_helper'

class OnOffGridTest < MiniTest::Test
  def test_empty_grid
    grid = OnOffLightGrid.new(20)
    assert_equal 0, grid.count_of_lit_lights
  end
  
  def test_turn_on_one_light
    grid = OnOffLightGrid.new(20)
    grid.turn_on!([2,2], [2,2])
    assert_equal 1, grid.count_of_lit_lights
  end
  
  def test_turn_on_one_row
    grid = OnOffLightGrid.new(20)
    grid.turn_on!([2,2], [5,2])
    assert_equal 4, grid.count_of_lit_lights
  end
  
  def test_turn_on_one_column
    grid = OnOffLightGrid.new(20)
    grid.turn_on!([2,2], [2,5])
    assert_equal 4, grid.count_of_lit_lights
  end
  
  def test_turn_on_range
    grid = OnOffLightGrid.new(20)
    grid.turn_on!([2,2], [4,5])
    assert_equal 12, grid.count_of_lit_lights
  end
  
  def test_turn_on_full_range
    grid = OnOffLightGrid.new(20)
    grid.turn_on!([0,0], [19,19])
    assert_equal 400, grid.count_of_lit_lights
  end
  
  def test_turn_off_all
    grid = OnOffLightGrid.new(20)
    grid.turn_on!([0,0], [2,2])
    grid.turn_off!([0,0], [19,19])
    assert_equal 0, grid.count_of_lit_lights
  end
  
  def test_turn_off_subset
    grid = OnOffLightGrid.new(20)
    grid.turn_on!([0,0], [0,2])
    grid.turn_off!([0,1], [0,2])
    assert_equal 1, grid.count_of_lit_lights
  end
  
  def test_toggle
    grid = OnOffLightGrid.new(20)
    grid.turn_on!([0,0], [4,0])
    grid.toggle!([0,0], [6,0])
    assert_equal 2, grid.count_of_lit_lights
  end
  
  def test_toggle_cancels_itself
    grid = OnOffLightGrid.new(20)
    grid.toggle!([0,0], [2,2])
    grid.toggle!([0,0], [2,2])
    assert_equal 0, grid.count_of_lit_lights
  end
end

class BrightnessGridTest < MiniTest::Test
  def test_empty_grid
    grid = BrightnessLightGrid.new(20)
    assert_equal 0, grid.total_brightness
  end
  
  def test_increase_brightness_of_one_light
    grid = BrightnessLightGrid.new(20)
    grid.increase_brightness!([2,2], [2,2], 10)
    assert_equal 10, grid.total_brightness
  end
  
  def test_increase_brightness_of_range
    grid = BrightnessLightGrid.new(20)
    grid.increase_brightness!([2,2], [4,5], 1)
    assert_equal 12, grid.total_brightness
  end
  
  def test_decrease_brightness
    grid = BrightnessLightGrid.new(20)
    grid.increase_brightness!([2,2], [4,5], 3)
    grid.decrease_brightness!([2,2], [4,5], 1)
    assert_equal 24, grid.total_brightness
  end
  
  def test_decrease_brightness_has_minimum_of_0
    grid = BrightnessLightGrid.new(20)
    grid.increase_brightness!([2,2], [2,2], 5)
    grid.decrease_brightness!([2,2], [2,2], 10)
    grid.increase_brightness!([2,2], [2,2], 1)
    assert_equal 1, grid.total_brightness
  end
end


class InstructionParsingTest < MiniTest::Test
  def test_parse_no_instructions
    instructions = ""
    parsed = InstructionsParser.new(make_reader(instructions))
    assert_equal [], parsed.to_a
  end
  
  def test_parse_one_instruction
    instructions = "turn on 0,0 through 999,999"
    parsed = InstructionsParser.new(make_reader(instructions))
    assert_equal [[:turn_on, [0,0], [999,999]]], parsed.to_a
  end
  
  def test_parse_one_instruction_with_ending_newline
    instructions = "turn on 0,0 through 999,999\n"
    parsed = InstructionsParser.new(make_reader(instructions))
    assert_equal [[:turn_on, [0,0], [999,999]]], parsed.to_a
  end
  
  def test_parse_multiple_instructions
    instructions = [
      "turn on 0,0 through 999,999",
      "toggle 0,0 through 999,0",
      "turn off 499,499 through 500,500",
    ].join("\n")
    parsed = InstructionsParser.new(make_reader(instructions))
    assert_equal [
      [:turn_on, [0,0], [999,999]],
      [:toggle, [0,0], [999,0]],
      [:turn_off, [499,499], [500,500]],
    ], parsed.to_a
  end
  
  def test_raise_when_parsing_unknown_instruction
    bad_instruction = "color lights 0,0 through 999,999 red"
    instructions = bad_instruction
    parsed = InstructionsParser.new(make_reader(instructions))
    
    error = assert_raises(InstructionsParser::ParseError) { parsed.to_a }
    assert_includes error.message, bad_instruction
  end
  
  private
  
  def make_reader(instruction_string)
    StringIO.new(instruction_string)
  end
end


class InstructionExecutingTest < MiniTest::Test
  def test_on_off_instruction_execution
    parsed_instructions = [
      [:turn_on, [0,0], [999,999]],
      [:toggle, [0,0], [999,0]],
      [:turn_off, [499,499], [500,500]],
    ]
    light_grid = Minitest::Mock.new
    light_grid.expect :turn_on!, nil, [[0,0], [999,999]]
    light_grid.expect :toggle!, nil, [[0,0], [999,0]]
    light_grid.expect :turn_off!, nil, [[499,499], [500,500]]
    
    executor = OnOffInstructionsExecutor.new(light_grid)
    executor.execute!(parsed_instructions)
    
    light_grid.verify
  end
  
  def test_brightness_instruction_execution
    parsed_instructions = [
      [:turn_on, [0,0], [999,999]],
      [:toggle, [0,0], [999,0]],
      [:turn_off, [499,499], [500,500]],
    ]
    light_grid = Minitest::Mock.new
    light_grid.expect :increase_brightness!, nil, [[0,0], [999,999], 1]
    light_grid.expect :increase_brightness!, nil, [[0,0], [999,0], 2]
    light_grid.expect :decrease_brightness!, nil, [[499,499], [500,500], 1]
    
    executor = BrightnessInstructionsExecutor.new(light_grid)
    executor.execute!(parsed_instructions)
    
    light_grid.verify
  end
end
