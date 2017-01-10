defmodule BoardTests do
  use ExUnit.Case

  test "can create a board" do
    board = Board.create()

    assert board == {:x, [["1", "2", "3"], ["4", "5", "6"],[ "7", "8", "9"]], :first_turn}  
  end

  test "can place a marker on the bord" do
    board = Board.create()
    changed_board = Board.place_marker(6,board)

    assert changed_board == {:x, [["1","2","3"],["4","5","X"],["7","8","9"]], :continue}
  end

  test "it can detect if a tile has already been taken" do
    assert Board.check_tile_not_taken([["1","2","3"],["4","5","X"],["7","8","9"]], 6) == :tile_already_selected
  end
end
