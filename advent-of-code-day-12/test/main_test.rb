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
  
  
  def test_sum_numbers_not_in_red_objects_still_sums
    json = '[1,2,3]'
    assert_equal 6, sum_numbers_not_in_red_objects(json)
  end
  
  def test_sum_numbers_not_in_red_objects_ignores_red
    json = '[1,{"c":"red","b":2},3]'
    assert_equal 4, sum_numbers_not_in_red_objects(json)
  end
  
  def test_sum_numbers_not_in_red_objects_accepts_other_objects_within_array
    json = '[1,{"c":"red","b":2},{"d":"blue","b":5},3]'
    assert_equal 9, sum_numbers_not_in_red_objects(json)
  end
  
  def test_sum_numbers_not_in_red_objects_accepts_other_objects_within_object
    json = '{"badsubobj":{"c":"red","b":2}, "goodnum":1, "goodsubobj":{"d":"blue","b":5}}'
    assert_equal 6, sum_numbers_not_in_red_objects(json)
  end
  
  def test_sum_numbers_not_in_red_objects_can_ignore_all
    json = '{"d":"red","e":[1,2,3,4],"f":5}'
    assert_equal 0, sum_numbers_not_in_red_objects(json)
  end
  
  def test_sum_numbers_not_in_red_objects_allows_red_arrays
    json = '[1,"red",5]'
    assert_equal 6, sum_numbers_not_in_red_objects(json)
  end
end
