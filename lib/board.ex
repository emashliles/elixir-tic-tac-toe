defmodule Board do

  def create(board_size) do
    {:x, ["1","2","3","4","5","6","7","8","9"], :first_turn}
  end

  def place_marker(selected_tile, game_status) do
    String.to_integer(selected_tile)
    |> zero_index_selection() 
    |> replace_marker_on_board(game_status)
  end

  def zero_index_selection(selected_tile) do
    selected_tile - 1
  end

  def replace_marker_on_board(selected_tile, game_status) do
    marker = elem(game_status, 0)
    elem(game_status, 1)
    |> check_tile_not_taken(selected_tile, marker)
  end

  def check_tile_not_taken(board, selected_tile, marker) do
    selected_tile_string = Integer.to_string(selected_tile + 1)
    if Enum.at(board,selected_tile) != selected_tile_string do
      create_next_game_status(board, marker, :tile_already_selected)
    else
      replace_marker_in_board_list(board, selected_tile, marker)
      |>create_next_game_status(marker, :continue)
    end
  end

  def replace_marker_in_board_list(board,selected_tile,marker) do
   marker_string = get_marker_symbol(marker)
   List.replace_at(board,selected_tile, marker_string)
  end

  def create_next_game_status(board, marker, :continue) do
    {marker, board,:continue}
  end

  def create_next_game_status(board, marker, :tile_already_selected) do
    {marker, board,:tile_already_selected}
  end

  def get_marker_symbol(marker) do
    available_markers = [{:x, "X"}, {:o, "O"}]
    available_markers[marker]
  end
end
