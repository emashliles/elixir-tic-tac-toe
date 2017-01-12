defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "TTT can return and empty game status" do
    assert TicTacToe.first_game_status() == {:x, [["1","2","3"],["4","5","6"],["7","8","9"]], :first_turn}
  end

  test "player can select space 5" do
    assert TicTacToe.make_move(4, {:x ,[["1","2","3"],["4","5","6"],["7","8","9"]], :continue}) == {:o,[["1","2","3"],["4","X","6"],["7","8","9"]], :continue}   
  end

  test "player can select space 9" do
    assert TicTacToe.make_move(8, {:x, [["1","2","3"],["4","5","6"],["7","8","9"]], :continue}) == {:o, [["1","2","3"],["4","5","6"],["7","8","X"]], :continue} 
  end

  test "player can select space 1" do
    assert TicTacToe.make_move(0, {:x, [["1","2","3"],["4","5","6"],["7","8","9"]], :continue}) == {:o, [["X","2","3"],["4","5","6"],["7","8","9"]], :continue} 
  end
  
  test "different player can select a space" do
    assert TicTacToe.make_move(0, {:o, [["1","2","3"],["4","X","6"],["7","8","9"]], :continue}) == {:x, [["O","2","3"],["4","X","6"],["7","8","9"]], :continue}
  end

  test "spaces cannot be selected twice" do
    assert TicTacToe.make_move(0, {:o,[["O","2","3"],["4","X","6"],["7","8","9"]], :continue}) == {:o, [["O","2","3"],["4","X","6"],["7","8","9"]], :space_already_selected}
  end
end
