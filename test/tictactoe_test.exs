defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "it can retrun and empty board" do
    assert TicTacToe.make_move() == ["1","2","3","4","5","6","7","8","9"]
  end

  test "player can select tile 5" do
    assert TicTacToe.make_move(5,["1","2","3","4","5","6","7","8","9"]) == ["1","2","3","4","X","6","7","8","9"]   
  end

  test "player can select tile 9" do
    assert TicTacToe.make_move(9,["1","2","3","4","5","6","7","8","9"]) == ["1","2","3","4","5","6","7","8","X"] 
  end

  test "player can select tile 1" do
    assert TicTacToe.make_move(1,["1","2","3","4","5","6","7","8","9"]) == ["X","2","3","4","5","6","7","8","9"] 
  end

end
