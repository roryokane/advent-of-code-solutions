require_relative 'test_helper'

class MainTest < MiniTest::Test
  def test_parse_one_number
    num_str = '135'
    assert_equal 135, parse_number_string(num_str)
  end
  
  def test_parse_number_with_lots_of_notation
    num_str = '-1.5e1'
    assert_equal (-15), parse_number_string(num_str)
  end
end
