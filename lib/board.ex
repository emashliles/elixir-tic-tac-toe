defmodule Board do

  @markers ["X","O"]
  def create(board_size) do
    {:x, ["1","2","3","4","5","6","7","8","9"], :first_turn}
  end

  def place_marker(selected_tile, game_status) do
    marker = elem(game_status, 0)
    elem(game_status, 1)
    |> check_tile_not_taken(selected_tile, marker)
  end

  def check_tile_not_taken(board, selected_tile, marker) do
    selection_value = Enum.at(board,zero_index_selection(selected_tile))
     Enum.member?(@markers,selection_value)
     |> create_next_game_status(board, marker, selected_tile)
  end

  def replace_marker_in_board(board,selected_tile,marker) do
   marker_string = get_marker_symbol(marker)
   index_selection = zero_index_selection(selected_tile)
   List.replace_at(board,index_selection, marker_string)
  end
  
  def create_next_game_status(is_duplicate_selection, board, marker, selected_tile) when is_duplicate_selection === false  do
    new_board = replace_marker_in_board(board, selected_tile, marker)
    {marker,new_board,:continue}
  end

  def create_next_game_status(is_duplicate_selection, board, marker, _) when is_duplicate_selection === true do
    {marker, board,:tile_already_selected}
  end

  def get_marker_symbol(marker) do
    available_markers = [{:x, "X"}, {:o, "O"}]
    available_markers[marker]
  end

  def zero_index_selection(selected_tile) do
    selected_tile - 1
  end
end
