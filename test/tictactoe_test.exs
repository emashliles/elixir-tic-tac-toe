defmodule TictactoeTest do
  use ExUnit.Case
  doctest Tictactoe

  test "it can print the board" do
    assert Tictactoe.play() == "123/n456/n789"
  end
end
