defmodule TicTacToe do

  def make_move() do
    "123\n456\n789"
  end

  def make_move(selected_tile) when is_integer(selected_tile) do
    selected_tile
    |> Integer.to_string()
    |> make_move()
  end

  def make_move(selected_tile) do
    String.replace("123\n456\n789",selected_tile,"X")
  end
end
