defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "it can print the board" do
    assert TicTacToe.play() == '123\n456\n789'
  end

  test "player can select tile 5" do
    assert TicTacToe.play(5) == '123\n4X6\n789'
  end

  test "player can select tile 9" do
    assert TicTacToe.play(9) == '123\n456\n78X'
  end

end
