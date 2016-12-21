defmodule Mix.Tasks.TicTacToe do
  use Mix.Task

  @shortdoc "Runs TicTacToe"
  def run(_) do
    IO.puts TicTacToe.start()
    run()
  end

  def run() do
   IO.puts TicTacToe.start(String.trim(IO.gets("Please enter a tile selection:")))
   run()
  end
end

