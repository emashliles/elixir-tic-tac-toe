defmodule TicTacToe do
  
import Board

  def make_move() do
    Board.create(3)
  end

  def make_move(selected_tile, board) when is_integer(selected_tile) do
    selected_tile
    |> Integer.to_string()
    |> make_move(board)
  end

  def make_move(selected_tile, board) do
    Board.place_marker(selected_tile,board, "X")
  end
end
