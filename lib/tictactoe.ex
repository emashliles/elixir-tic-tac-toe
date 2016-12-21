defmodule TicTacToe do
  use Mix.Task

  def start() do
    IO.puts(play())
  end

  def play() do
    "123\n456\n789"
  end
#
#  def play(5) do
#    '123\n4X6\n789'
#  end
#
#  def play(9) do
#    '123\n456\n78X'
#  end
#
#  def play(1) do
#    'X23\n456\n789'
#  end

  def play(x) do
    String.replace("123\n456\n789",Integer.to_string(x),"X")
  end

end
