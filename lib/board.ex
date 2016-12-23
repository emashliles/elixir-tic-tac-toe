defmodule Board do

  def create(board_size) do
    ["1","2","3","4","5","6","7","8","9"]
  end

  def place_marker(selected_tile, board, marker) do
   String.to_integer(selected_tile)
   |> zero_index_selection() 
   |> (&List.replace_at(board,&1, "X")).() 
  end

  def zero_index_selection(selected_tile) do
    selected_tile - 1
  end
end
