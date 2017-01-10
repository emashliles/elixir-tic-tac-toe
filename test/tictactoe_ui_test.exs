defmodule TicTacToe.UI.Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "can print the board" do
    assert capture_io(fn -> TicTacToe.UI.start_game() end) == "\e[H\e[2J\n 1 | 2 | 3 \n===========\n 4 | 5 | 6 \n===========\n 7 | 8 | 9 \n"
  end
  
  test "can print the board after player one input" do
    assert capture_io([input: "1"],fn ->  TicTacToe.UI.get_move({:x,[["1","2","3"],["4","5","6"],["7","8","9"]], :continue})end) == "Please enter a tile selection: \e[H\e[2J\n X | 2 | 3 \n===========\n 4 | 5 | 6 \n===========\n 7 | 8 | 9 \n"  
  end

  test "can print the board after player two input" do
    assert capture_io([input: "2"],fn ->  TicTacToe.UI.get_move({:o,[["X","2","3"],["4","5","6"],["7","8","9"]], :continue})end) == "Please enter a tile selection: \e[H\e[2J\n X | O | 3 \n===========\n 4 | 5 | 6 \n===========\n 7 | 8 | 9 \n"  
  end

  test "prints correct message after duplicate tile selected" do
    assert capture_io([input: "5"],fn ->  TicTacToe.UI.get_move({:o,[["X","2","3"],["4","X","6"],["7","8","9"]], :get_player_move})end) == "Please enter a tile selection: \e[H\e[2J\nTile already selected. Please select a different tile.\n X | 2 | 3 \n===========\n 4 | X | 6 \n===========\n 7 | 8 | 9 \n"  
  end

  test "prints correct message and ends when a win is detected" do
    assert capture_io([input: "5"],fn ->  TicTacToe.UI.get_move({:x,[["X","2","3"],["4","5","6"],["7","8","X"]], :continue})end) == "Please enter a tile selection: \e[H\e[2J\nPlayer X has won the game.\n X | 2 | 3 \n===========\n 4 | X | 6 \n===========\n 7 | 8 | X \nGoodbye.\n"
  end

  test "prints correct message and ends when a tie is detected" do
    assert capture_io([input: "5"],fn ->  TicTacToe.UI.get_move({:x,[["O","O","X"],["X","5","O"],["O","X","O"]]  , :continue})end) == "Please enter a tile selection: \e[H\e[2J\nThis game is a tie.\n O | O | X \n===========\n X | X | O \n===========\n O | X | O \nGoodbye.\n"
  end

  test "formats the board" do
    assert TicTacToe.UI.format_board([["1","2","3"], ["4","5","6"], ["7","8","9"]]) == [[" 1 ","|"," 2 ", "|"," 3 ", "\n"],["===========", "\n"],[" 4 ", "|"," 5 ", "|"," 6 ", "\n"],["===========", "\n"],[" 7 ", "|"," 8 ", "|"," 9 ", "\n"]]
  end

  test "prompt is given for player to re-take turn on bad input" do
    game_output = capture_io([input: "five\n5"],fn ->  TicTacToe.UI.get_move({:x,[["O","O","X"],["X","5","O"],["O","X","O"]]  , :continue})end)
    assert String.contains?(game_output,"Bad input. Player X, please re-enter selection.\n O | O | X \n===========\n X | 5 | O \n===========\n O | X | O \n")
  end

  test "will return :bad_input if a string was entered" do
    assert TicTacToe.UI.check_tile_selection("five") == :bad_input
  end

  test "will return :bad_input if input is negative" do
    assert TicTacToe.UI.check_tile_selection("-1") == :bad_input
  end

  test "will return :bad_input if input is larger than the board" do
    game_output = capture_io([input: "9999999\n9"],fn ->  TicTacToe.UI.get_move({:x,[["O","O","X"],["X","5","O"],["O","X","O"]]  , :continue})end)
    assert String.contains?(game_output,"Bad input. Player X, please re-enter selection.\n O | O | X \n===========\n X | 5 | O \n===========\n O | X | O \n")
  end
end

 
