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
    modified_board = Board.place_marker(selected_tile,board)
    change_player(modified_board, elem(modified_board,0), elem(modified_board,2 ))
  end

  def change_player(board, :o, :continue) do 
    {:x, elem(board, 1), :continue}
  end

  def change_player(board, :x, :continue) do 
    {:o ,elem(board, 1), :continue}
  end

  def change_player(board, player, :tile_already_selected) do
    {player, elem(board, 1), :tile_already_selected}
  end

end
