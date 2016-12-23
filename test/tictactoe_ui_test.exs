defmodule TicTacToe.UI.Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "can print the board" do
    assert capture_io(fn -> TicTacToe.UI.start_game() end) == "123\n456\n789\n"
  end
  
  test "can print the board after user input" do
    assert capture_io([input: "1"],fn ->  TicTacToe.UI.get_move({:x,["1","2","3","4","5","6","7","8","9"]})end) == "Please enter a tile selection:X23\n456\n789\n"  
  end

  test "can print the board after different user input" do
    assert capture_io([input: "2"],fn ->  TicTacToe.UI.get_move({:o,["X","2","3","4","5","6","7","8","9"]})end) == "Please enter a tile selection:XO3\n456\n789\n"  
  end

end
