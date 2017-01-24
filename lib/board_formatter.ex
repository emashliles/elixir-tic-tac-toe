defmodule BoardFormatter do

  def format_board(board) do
    board
    |> add_spaces([])
    |> add_lines([])
    |> add_separators
    |> insert_new_lines([])
  end

  defp add_spaces([], accumulator), do: accumulator
  defp add_spaces([head | tail], accumulator) do
    spaced_row = pad(head)
    list = List.insert_at(accumulator, 100, spaced_row)
    add_spaces(tail, list)
  end

  defp pad(row) do
    Enum.map(row, fn(value) ->
      value
      |> String.pad_trailing(2)
      |> String.pad_leading(3)
    end)
  end

  defp add_lines([], accumulator), do: accumulator
  defp add_lines([head | tail], accumulator) do
    lined_row = accumulator ++  [Enum.intersperse(head, "|")]
    add_lines(tail, lined_row)
  end
  
  defp add_separators(board) do
    row_length = get_chars_in_each_row(board)
    separator =  String.duplicate("=", row_length)
    Enum.intersperse(board, [separator])
  end

  defp insert_new_lines([], accumulator), do: accumulator
  defp insert_new_lines([head | tail], accumulator) do
    row_with_newline = List.insert_at(accumulator, -1,  head ++ ["\n"])
    insert_new_lines(tail, row_with_newline)
  end

  defp get_chars_in_each_row(board) do
    List.first(board)
    |> List.to_string()
    |> String.length()
  end
end
