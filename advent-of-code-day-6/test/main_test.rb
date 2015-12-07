require 'stringio'
require_relative 'test_helper'

class GridTest < MiniTest::Test
  def test_empty_grid
    grid = LightGrid.new(20)
    assert_equal 0, grid.count_of_lit_lights
  end
  
  def test_turn_on_one_light
    grid = LightGrid.new(20)
    grid.turn_on!([2,2], [2,2])
    assert_equal 1, grid.count_of_lit_lights
  end
  
  def test_turn_on_one_row
    grid = LightGrid.new(20)
    grid.turn_on!([2,2], [5,2])
    assert_equal 4, grid.count_of_lit_lights
  end
  
  def test_turn_on_one_column
    grid = LightGrid.new(20)
    grid.turn_on!([2,2], [2,5])
    assert_equal 4, grid.count_of_lit_lights
  end
  
  def test_turn_on_range
    grid = LightGrid.new(20)
    grid.turn_on!([2,2], [4,5])
    assert_equal 12, grid.count_of_lit_lights
  end
  
  def test_turn_on_full_range
    grid = LightGrid.new(20)
    grid.turn_on!([0,0], [19,19])
    assert_equal 400, grid.count_of_lit_lights
  end
  
  def test_turn_off_all
    grid = LightGrid.new(20)
    grid.turn_on!([0,0], [2,2])
    grid.turn_off!([0,0], [19,19])
    assert_equal 0, grid.count_of_lit_lights
  end
  
  def test_turn_off_subset
    grid = LightGrid.new(20)
    grid.turn_on!([0,0], [0,2])
    grid.turn_off!([0,1], [0,2])
    assert_equal 1, grid.count_of_lit_lights
  end
  
  def test_toggle
    grid = LightGrid.new(20)
    grid.turn_on!([0,0], [4,0])
    grid.toggle!([0,0], [6,0])
    assert_equal 2, grid.count_of_lit_lights
  end
  
  def test_toggle_cancels_itself
    grid = LightGrid.new(20)
    grid.toggle!([0,0], [2,2])
    grid.toggle!([0,0], [2,2])
    assert_equal 0, grid.count_of_lit_lights
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
  def test_instruction_execution
    parsed_instructions = [
      [:turn_on, [0,0], [999,999]],
      [:toggle, [0,0], [999,0]],
      [:turn_off, [499,499], [500,500]],
    ]
    light_grid = Minitest::Mock.new
    light_grid.expect :turn_on!, nil, [[0,0], [999,999]]
    light_grid.expect :toggle!, nil, [[0,0], [999,0]]
    light_grid.expect :turn_off!, nil, [[499,499], [500,500]]
    
    executor = InstructionsExecutor.new(light_grid)
    executor.execute!(parsed_instructions)
    
    light_grid.verify
  end
end
