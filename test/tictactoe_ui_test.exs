defmodule TicTacToe.UI.Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "can print the board" do
    assert capture_io(fn -> TicTacToe.UI.start_game() end) == "123\n456\n789\n"
  end
  
  test "can print the board after user input" do
    assert capture_io([input: "1"],fn ->  TicTacToe.UI.get_move()end) == "Please enter a tile selection:X23\n456\n789\n"  
  end
end
