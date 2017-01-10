defmodule Board do

  def create() do
    {:x, [["1","2","3"],["4","5","6"],["7","8","9"]], :first_turn}
  end

  def place_marker(selected_tile, game_status) do
    player_symbol = elem(game_status, 0)
    create_next_game_status(elem(game_status, 1), player_symbol, selected_tile)
  end

  def check_tile_not_taken(board, selected_tile, player_symbol) do
     selection_value = get_value_of_selected_tile(zero_index_selection(selected_tile), board)
    
   if Enum.member?(get_all_marker_values,selection_value) do
     :tile_already_selected
   else
     :continue
   end
  end

  def create_next_game_status( board, player_symbol, selected_tile) do
    new_board = replace_marker_in_board(board, selected_tile, player_symbol)
    turn_type = WinOrTieChecker.check_if_win_or_tie(new_board)
    {player_symbol,new_board,turn_type}
  end

  def replace_marker_in_board(board,selected_tile,player_symbol) do
    marker_string = get_marker_symbol(player_symbol)
    index_selection = zero_index_selection(selected_tile)
    row_size = length(board)
    
    do_replace_marker_in_board(board, index_selection, marker_string, row_size)
  end

  def do_replace_marker_in_board(board, index_selection, marker_string,row_size) do
    List.flatten(board)
    |> List.replace_at(index_selection, marker_string)
    |> divide_board_into_rows(row_size)
  end

  def get_value_of_selected_tile(selected_tile, board) do
    List.flatten(board)
    |> Enum.at(selected_tile)
  end
  
  def get_marker_symbol(player_symbol), do: Markers.get_player_marker(player_symbol)

  def get_all_marker_values(), do: Markers.get_all_markers()

  def zero_index_selection(selected_tile), do: selected_tile - 1

  def divide_board_into_rows(board, row_size), do: Enum.chunk(board, row_size)

end
