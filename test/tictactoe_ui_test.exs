defmodule TicTacToe.UI.Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "prints the board" do
    assert capture_io(fn -> TicTacToe.UI.start_game() end) == "\e[H\e[2J\n 1 | 2 | 3 \n===========\n 4 | 5 | 6 \n===========\n 7 | 8 | 9 \n"
  end
  
  test "prints the board after player one input" do
    assert capture_io([input: "1"],fn ->  TicTacToe.UI.do_turn({:x,[["1","2","3"],["4","5","6"],["7","8","9"]], :continue})end) == "Please enter a space selection: \e[H\e[2J\n X | 2 | 3 \n===========\n 4 | 5 | 6 \n===========\n 7 | 8 | 9 \n"  
  end

  test "prints the board after player two input" do
    assert capture_io([input: "2"],fn ->  TicTacToe.UI.do_turn({:o,[["X","2","3"],["4","5","6"],["7","8","9"]], :continue})end) == "Please enter a space selection: \e[H\e[2J\n X | O | 3 \n===========\n 4 | 5 | 6 \n===========\n 7 | 8 | 9 \n"  
  end

  test "prints correct message after duplicate space selected" do
    assert capture_io([input: "5"],fn ->  TicTacToe.UI.do_turn({:o,[["X","2","3"],["4","X","6"],["7","8","9"]], :get_player_move})end) == "Please enter a space selection: \e[H\e[2J\n X | 2 | 3 \n===========\n 4 | X | 6 \n===========\n 7 | 8 | 9 \nSpace already selected. Please select a different space.\n"  
  end

  test "prints correct message and ends when a win is detected" do
    assert capture_io([input: "5"],fn ->  TicTacToe.UI.do_turn({:x,[["X","2","3"],["4","5","6"],["7","8","X"]], :continue})end) == "Please enter a space selection: \e[H\e[2J\n X | 2 | 3 \n===========\n 4 | X | 6 \n===========\n 7 | 8 | X \nPlayer X has won the game.\n"
  end

  test "prints correct message when a tie is detected" do
    assert capture_io([input: "5"],fn ->  TicTacToe.UI.do_turn({:x,[["O","O","X"],["X","5","O"],["O","X","O"]]  , :continue})end) == "Please enter a space selection: \e[H\e[2J\n O | O | X \n===========\n X | X | O \n===========\n O | X | O \nThis game is a tie.\n"
  end

  test "prompt is given for player to re-take turn on bad input" do
    game_output = capture_io([input: "five\n5"],fn ->  TicTacToe.UI.do_turn({:x,[["O","O","X"],["X","5","O"],["O","X","O"]]  , :continue})end)
    assert String.contains?(game_output,"\n O | O | X \n===========\n X | 5 | O \n===========\n O | X | O \nBad input. Player X, please re-enter selection.")
  end

  test "will return :bad_input if a string was entered" do
    assert TicTacToe.UI.check_space_selection("five") == :bad_input
  end

  test "will return :bad_input if input is negative" do
    assert TicTacToe.UI.check_space_selection("-1") == :bad_input
  end

  test "will return :bad_input if input is larger than the board" do
    game_output = capture_io([input: "9999999\n9"],fn ->  TicTacToe.UI.do_turn({:x,[["O","O","X"],["X","5","O"],["O","X","O"]]  , :continue})end)
    assert String.contains?(game_output,"Please enter a space selection: \e[H\e[2J\n O | O | X \n===========\n X | 5 | O \n===========\n O | X | O \nBad input. Player X, please re-enter selection.\n")
  end

  test "replay option is given after a game has been won" do
    assert capture_io([input: "5\nn"],fn ->  TicTacToe.UI.game_loop({:x,[["O","O","X"],["X","5","O"],["O","X","O"]]  , :continue})end) == "Please enter a space selection: \e[H\e[2J\n O | O | X \n===========\n X | X | O \n===========\n O | X | O \nThis game is a tie.\nPlay again? y/n\nGoodbye\n"
  end
end
