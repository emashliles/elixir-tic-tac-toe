defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "it can print the board" do
    assert TicTacToe.play() == "123\n456\n789"
  end
end
