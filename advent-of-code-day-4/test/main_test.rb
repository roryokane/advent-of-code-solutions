require_relative 'test_helper'

class MainTest < MiniTest::Test
  def test_md5
    assert_equal "000001dbbfa3a5c83a2d506429c7b00e", Hasher.md5("abcdef", 609043)
  end
  
  def test_starts_with_zeroes_proc
    three_zeroes_prefix = Hasher.starts_with_zeroes_proc(3)
    assert_equal true, three_zeroes_prefix.call("000abc")
    assert_equal false, three_zeroes_prefix.call("00def")
    assert_equal false, three_zeroes_prefix.call("ghi000")
  end
  
  def test_lowest_initial_zeroes_added_number
    assert_equal 609043, Hasher.lowest_initial_zeroes_added_number("abcdef", 5)
  end
end
