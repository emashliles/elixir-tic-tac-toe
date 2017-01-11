defmodule Board do

  def create do
    [["1","2","3"],["4","5","6"],["7","8","9"]]
  end

  def place_marker(selected_tile, board, player_symbol) do
    new_board = replace_marker_in_board(board, selected_tile, player_symbol)
    turn_type = WinOrTieChecker.check_if_win_or_tie(new_board)
    new_board
  end

  def check_tile_not_taken(board, selected_tile) do
    selection_value = get_value_of_selected_tile(zero_index_selection(selected_tile), board)

   if Enum.member?(get_all_marker_values,selection_value) do
     :tile_already_selected
   else
     :continue
   end
  end

  def size(board) do  
    board
    |> List.flatten()
    |> length
  end

  defp replace_marker_in_board(board,selected_tile,player_symbol) do
    marker_string = Markers.get_player_marker(player_symbol)
    index_selection = zero_index_selection(selected_tile)
    row_size = length(board)

    do_replace_marker_in_board(board, index_selection, marker_string, row_size)
  end

  defp do_replace_marker_in_board(board, index_selection, marker_string,row_size) do
    List.flatten(board)
    |> List.replace_at(index_selection, marker_string)
    |> divide_board_into_rows(row_size)
  end

  defp get_value_of_selected_tile(selected_tile, board) do
    List.flatten(board)
    |> Enum.at(selected_tile)
  end

  defp get_all_marker_values(), do: Markers.get_all_markers()

  defp zero_index_selection(selected_tile), do: selected_tile - 1

  defp divide_board_into_rows(board, row_size), do: Enum.chunk(board, row_size)

end
