defmodule Board do

  @markers ["X","O"]

  def create(board_size) do
    {:x, [["1","2","3"],["4","5","6"],["7","8","9"]], :first_turn}
  end

  def place_marker(selected_tile, game_status) do
    marker = elem(game_status, 0)
    elem(game_status, 1)
    |> check_tile_not_taken(selected_tile, marker)
  end

  def check_tile_not_taken(board, selected_tile, marker) do
     selection_value = get_value_of_selected_tile(zero_index_selection(selected_tile), board)
     Enum.member?(@markers,selection_value)
     |> create_next_game_status(board, marker, selected_tile)
  end

  def replace_marker_in_board(board,selected_tile,marker) do
   marker_string = get_marker_symbol(marker)
   index_selection = zero_index_selection(selected_tile)
   row_size = length(board)
   List.flatten(board)
   |> List.replace_at(index_selection, marker_string)
   |> divide_board_into_rows(row_size)
  end

  def divide_board_into_rows(board, row_size) do
    Enum.chunk(board, row_size)
  end

  def create_next_game_status(is_duplicate_selection, board, marker, selected_tile) when is_duplicate_selection === false  do
    new_board = replace_marker_in_board(board, selected_tile, marker)
    turn_type = WinOrTieChecker.check_if_win_or_tie(new_board)
    {marker,new_board,turn_type}
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

  def get_value_of_selected_tile(selected_tile, board) do
    List.flatten(board)
    |> Enum.at(selected_tile)
  end
end
