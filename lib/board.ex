defmodule Board do

  def create(board_size) do
    {:x, ["1","2","3","4","5","6","7","8","9"], :continue}
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
    game_status = elem(board, 2) 
    elem(board, 1)
    |> check_tile_not_taken(selected_tile, marker)
  end

  def check_tile_not_taken(board, selected_tile, marker) do
    selected_tile_string = Integer.to_string(selected_tile + 1)
    if Enum.at(board,selected_tile) != selected_tile_string do
      create_next_board(board, marker, :tile_already_selected)
    else
      replace_marker_in_board_list(board, selected_tile, marker)
      |>create_next_board(marker, :continue)
    end
  end

  def replace_marker_in_board_list(board,selected_tile,marker) do
   marker_string = get_marker_symbol(marker)
   List.replace_at(board,selected_tile, marker_string)
  end

  def create_next_board(board, marker, :continue) do
    {marker, board,:continue}
  end

  def create_next_board(board, marker, :tile_already_selected) do
    {marker, board,:tile_already_selected}
  end

  def get_marker_symbol(marker) do
    available_markers = [{:x, "X"}, {:o, "O"}]
    available_markers[marker]
  end
end
