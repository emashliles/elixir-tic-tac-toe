defmodule BoardTests do
  use ExUnit.Case

  test "can create a board" do
    assert Board.create == [["1", "2", "3"], ["4", "5", "6"],[ "7", "8", "9"]]
  end

  test "can place a marker on the bord" do
    board = Board.create
    changed_board = Board.place_marker(5, board, :x)

    assert changed_board == [["1","2","3"],["4","5","X"],["7","8","9"]]
  end

  test "can detect if a space has already been taken" do
    assert Board.check_space_not_taken([["1","2","3"],["4","5","X"],["7","8","9"]], 5) == :space_already_selected
  end

  test "board has a size" do
    board = Board.create
    assert Board.size(board) == 9 
  end

end
