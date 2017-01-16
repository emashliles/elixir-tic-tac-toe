defmodule Mix.Tasks.TicTacToe.Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "plays the game once" do
    game_output = capture_io([input: "1\n2\n3\n4\n5\n6\n7\nn"], fn -> TicTacToe.UI.start_game_loop()end)

    assert String.contains?(game_output, "Goodbye")
  end

  test "can replay the game" do
    game_output = capture_io([input: "1\n2\n3\n4\n5\n6\n7\ny\n1\n2\n3\n4\n5\n6\n7\nn"], fn -> TicTacToe.UI.start_game_loop()end)
    assert String.contains?(game_output, "Play again? y/n\n\e[H\e[2J\n 1 | 2 | 3 \n===========\n 4 | 5 | 6 \n===========\n 7 | 8 | 9 \n")
  end
end
