defmodule Mix.Tasks.TicTacToe do
  use Mix.Task

  @shortdoc "Runs TicTacToe"
  def run(_) do
    TicTacToe.UI.start_game()
    |> game_loop()
  end

 def game_loop(board) do
  TicTacToe.UI.get_move(board)
  |> game_loop()
 end

end

