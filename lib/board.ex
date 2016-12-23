defmodule Board do

  def create(board_size) do
    {:x, ["1","2","3","4","5","6","7","8","9"]}
  end

  def place_marker(selected_tile, board) do
   String.to_integer(selected_tile)
   |> zero_index_selection() 
   |> replace_marker_on_board(board)
  end

  def zero_index_selection(selected_tile) do
    selected_tile - 1
  end

  def replace_marker_on_board(selected_tile, board) do
    marker = elem(board, 0)
    
    elem(board, 1)
    |> replace_marker_in_board_list(selected_tile, marker)
    |> create_next_board(marker)
  end

  def replace_marker_in_board_list(board,selected_tile,marker) do
   marker_string = get_marker_symbol(marker)
   List.replace_at(board,selected_tile, marker_string)
  end

  def create_next_board(board, marker) do
    {marker, board}
  end

  def get_marker_symbol(marker) do
    available_markers = [{:x, "X"}, {:o, "O"}]
    available_markers[marker]
  end

end