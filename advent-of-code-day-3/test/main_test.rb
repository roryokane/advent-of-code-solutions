require_relative 'test_helper'

class MainTest < MiniTest::Test
  def test_empty_grid
    grid = Grid.new
    assert_equal [], grid.visited_coords
  end
  
  def test_visited_grid
    grid = Grid.new
    grid.visit!([0, 0])
    grid.visit!([0, -1])
    grid.visit!([1, -1])
    assert_equal [[0, 0], [0, -1], [1, -1]], grid.visited_coords
  end
  
  def test_movement_from_char
    assert_equal [3, 1],  Movement.moved_coord('^', [3, 0])
    assert_equal [4, 0],  Movement.moved_coord('>', [3, 0])
    assert_equal [3, -1], Movement.moved_coord('v', [3, 0])
    assert_equal [2, 0],  Movement.moved_coord('<', [3, 0])
  end
  
  def test_movement_ignores_unknown_char
    assert_equal [3, 0], Movement.moved_coord('?', [3, 0])
  end
  
  def test_single_santa_direction_grid
    assert_equal 5, SantaTravel.grid_from_following_directions("^><<v").visited_coords.size
  end
  
  def test_two_santa_direction_grid
    assert_equal 3, SantaTravel.grid_from_two_santas_following_directions("^v").visited_coords.size
    assert_equal 3, SantaTravel.grid_from_two_santas_following_directions("^>v<").visited_coords.size
    assert_equal 11, SantaTravel.grid_from_two_santas_following_directions("^v^v^v^v^v").visited_coords.size
  end
end
