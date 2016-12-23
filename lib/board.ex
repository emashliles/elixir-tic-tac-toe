defmodule Board do

  def create(board_size) do
    ["1","2","3","4","5","6","7","8","9"]
  end

  def place_marker(selected_tile, board, marker) do
   tile = String.to_integer(selected_tile)
   index_of_tile = (tile - 1 )
   new_board =  List.replace_at(board, index_of_tile , "X")
   new_board
  end
end
