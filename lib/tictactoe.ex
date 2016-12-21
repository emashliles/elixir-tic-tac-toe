defmodule TicTacToe do
  use Mix.Task

  def start() do
    IO.puts(play())
  end

  def start(selected_tile) do
    IO.puts(play(selected_tile))
  end

  def play() do
    "123\n456\n789"
  end

  def play(x) when is_integer(x) do
    play(Integer.to_string(x))
  end

  def play(x) do
    String.replace("123\n456\n789",x,"X")
  end

end
