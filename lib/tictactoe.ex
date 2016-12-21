defmodule TicTacToe do
  use Mix.Task

  def start() do
    make_move()
  end

  def start(selected_tile) do
    make_move(selected_tile)
  end

  def make_move() do
    "123\n456\n789"
  end

  def make_move(x) when is_integer(x) do
    make_move(Integer.to_string(x))
  end

  def make_move(x) do
    String.replace("123\n456\n789",x,"X")
  end

end
