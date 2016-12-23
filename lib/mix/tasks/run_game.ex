defmodule Mix.Tasks.TicTacToe do
  use Mix.Task

  @shortdoc "Runs TicTacToe"
  def run(_) do
    TicTacToe.UI.start_game()
    |> TicTacToe.UI.get_move()
    |> TicTacToe.UI.get_move()
  end
end

