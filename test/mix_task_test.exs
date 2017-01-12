defmodule Mix.Tasks.TicTacToe.Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "plays the game once" do
    game_output = capture_io([input: "1\n2\n3\n4\n5\n6\n7"], fn -> TicTacToe.UI.start_game_loop()end)

    assert String.contains?(game_output, "Goodbye")
  end
end
