defmodule TicTacToe do
  use Mix.Task

  def start() do
    play()
  end

  def play() do
    '123\n456\n789'
  end

  def play(5) do
    '123\n4X6\n789'
  end

  def play(9) do
    '123\n456\n78X'
  end

end
