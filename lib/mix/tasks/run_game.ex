defmodule Mix.Tasks.Tictactoe do
  use Mix.Task

  @shortdoc "Runs TicTacToe"
  def run(_) do
    Tictactoe.start()
  end
end
