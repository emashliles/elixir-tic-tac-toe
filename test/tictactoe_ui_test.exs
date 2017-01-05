defmodule TicTacToe.UI.Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "can print the board" do
    assert capture_io(fn -> TicTacToe.UI.start_game() end) == "1 2 3 \n4 5 6 \n7 8 9 \n"
  end
  
  test "can print the board after player one input" do
    assert capture_io([input: "1"],fn ->  TicTacToe.UI.get_move({:x,[["1","2","3"],["4","5","6"],["7","8","9"]], :continue})end) == "Please enter a tile selection:X 2 3 \n4 5 6 \n7 8 9 \n"  
  end

  test "can print the board after player two input" do
    assert capture_io([input: "2"],fn ->  TicTacToe.UI.get_move({:o,[["X","2","3"],["4","5","6"],["7","8","9"]], :continue})end) == "Please enter a tile selection:X O 3 \n4 5 6 \n7 8 9 \n"  
  end

  test "prints correct message after duplicate tile selected" do
    assert capture_io([input: "5"],fn ->  TicTacToe.UI.get_move({:o,[["X","2","3"],["4","X","6"],["7","8","9"]], :get_player_move})end) == "Please enter a tile selection:Tile already selected. Please select a different tile.\nX 2 3 \n4 X 6 \n7 8 9 \n"  
  end

  test "prints correct message and ends when a win is detected" do
    assert capture_io([input: "5"],fn ->  TicTacToe.UI.get_move({:x,[["X","2","3"],["4","5","6"],["7","8","X"]], :continue})end) == "Please enter a tile selection:Player X has won the game.\nX 2 3 \n4 X 6 \n7 8 X \nGoodbye.\n"
  end

  test "prints correct message and ends when a tie is detected" do
    assert capture_io([input: "5"],fn ->  TicTacToe.UI.get_move({:x,[["O","O","X"],["X","5","O"],["O","X","O"]]  , :continue})end) == "Please enter a tile selection:This game is a tie.\nO O X \nX X O \nO X O \nGoodbye.\n"
  end

  test "formats the board" do
    assert TicTacToe.UI.format_board([["1","2","3"], ["4","5","6"], ["7","8","9"]]) == [["1 ","2 ", "3 ", "\n"],["4 ", "5 ", "6 ", "\n"],["7 ", "8 ", "9 ", "\n"]]
  end
end
