require_relative 'test_helper'

class InstructionsParsingTest < MiniTest::Test
  def test_parse_no_instructions
    instructions = ""
    parsed = InstructionsParser.new(make_reader(instructions))
    assert_equal [], parsed.to_a
  end
  
  def test_parse_one_instruction
    instructions = "123 -> x"
    parsed = InstructionsParser.new(make_reader(instructions))
    assert_equal [{from: 123, to: :x}], parsed.to_a
  end
  
  def test_parse_one_instruction_with_ending_newline
    instructions = "123 -> x\n"
    parsed = InstructionsParser.new(make_reader(instructions))
    assert_equal [{}], parsed.to_a
  end
  
  def test_parse_all_instruction_types
    instructions = [
      "123 -> x",
      "x AND y -> z",
      "x OR y -> a",
      "p LSHIFT 2 -> q",
      "p RSHIFT 1 -> r",
      "NOT e -> f",
    ].join("\n")
    parsed = InstructionsParser.new(make_reader(instructions))
    assert_equal [
      {},
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
