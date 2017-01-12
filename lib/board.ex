defmodule Board do

  def create do
    [["1","2","3"],["4","5","6"],["7","8","9"]]
  end

  def place_marker(selected_space, board, player_symbol) do
    marker_string = Markers.from_player_symbol(player_symbol)
    row_size = length(board)

    do_replace_marker_in_board(board, selected_space, marker_string, row_size)
  end

  def check_space_not_taken(board, selected_space) do
    selection_value = get_value_of_selected_space(selected_space, board)

    if Enum.member?(Markers.all,selection_value) do
      :space_already_selected
    else
      :continue
    end
  end

  def size(board) do
    board
    |> List.flatten()
    |> length
  end

  defp do_replace_marker_in_board(board, index_selection, marker_string, row_size) do
    List.flatten(board)
    |> List.replace_at(index_selection, marker_string)
    |> divide_board_into_rows(row_size)
  end

  defp get_value_of_selected_space(selected_space, board) do
    List.flatten(board)
    |> Enum.at(selected_space)
  end

  defp divide_board_into_rows(board, row_size), do: Enum.chunk(board, row_size)
end
