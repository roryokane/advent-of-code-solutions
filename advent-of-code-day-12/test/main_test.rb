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
  
  def test_extract_simple_number_strings
    json = '[1, "abc", {"def": 23}]'
    assert_equal ['1', '23'], extract_number_strings(json)
  end
  
  def test_extract_strings_for_numbers_with_lots_of_notation
    json = '[-1.5e1, ["e", 3.66666]]'
    assert_equal ['-1.5e1', '3.66666'], extract_number_strings(json)
  end
  
  def test_sum_extracted_numbers
    json = '[1, "abc", {"def": 23}]'
    assert_equal 24, sum_extracted_numbers(json)
  end
end
