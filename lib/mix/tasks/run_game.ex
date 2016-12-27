defmodule Mix.Tasks.TicTacToe do
  use Mix.Task

  @shortdoc "Runs TicTacToe"
  def run(_) do
    TicTacToe.UI.start_game()
    |> game_loop()
  end

 def game_loop(board) do
  modified_board = TicTacToe.UI.get_move(board)
  elem(modified_board,2)
  |> continue_game(modified_board)
 end

 def continue_game(:continue, modified_board) do
   game_loop(modified_board)
 end
end

