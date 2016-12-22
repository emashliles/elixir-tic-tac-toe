defmodule Mix.Tasks.TicTacToe do
  use Mix.Task

  @shortdoc "Runs TicTacToe"
  def run(_) do
    TicTacToe.make_move()
    run()
  end

  def run() do
   IO.puts TicTacToe.make_move(String.trim(IO.gets("Please enter a tile selection:")))
   run()
  end
end

