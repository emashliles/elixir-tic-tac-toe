defmodule WinOrTieChecker do

  def check_if_win_or_tie(board) do
    check_for_winning_row(0,board)
    |> check_for_winning_columns(board, 0)
    |> check_for_winning_diagonal(board, 0, 1)
    |> check_for_winning_diagonal(board, (length(board)- 1),-1)
    |> check_for_tied_board(board)
  end

  def check_for_winning_row(1, _), do: :win

  def check_for_winning_row(_, []), do: :continue

  def check_for_winning_row(_, [head | tail]) do
    MapSet.new(head)
    |> MapSet.size()
    |> check_for_winning_row(tail)
  end

  def check_for_winning_columns(:win, _, _), do: :win

  def check_for_winning_columns(continue_or_win?, board, column_index) do
    unless length(board) <= column_index do
      check_for_winning_column(continue_or_win?, board, column_index)
       |> check_for_winning_columns(board,(column_index + 1))
    else
      :continue
    end
  end

  def check_for_winning_column(:win, _, _), do: :win

  def check_for_winning_column(:continue,board, column_index) do
    get_value_from_column(column_index,board,[])    
  end

  def get_value_from_column(column_index, [head | tail], column_values) do
    value = Enum.at(head,column_index)
    modified_column_values = [value] ++ column_values
    get_value_from_column(column_index, tail, modified_column_values)
  end

  def get_value_from_column(column_index, [], column_values) do
    Enum.dedup(column_values)
    |> length()
    |> column_is_win(column_index, column_values)
  end

  def column_is_win(1,_,_ ), do: :win

  def column_is_win(amount_of_values, column_index, _), do: :continue

  def check_for_winning_diagonal(:win, _, _, _), do: :win

  def check_for_winning_diagonal(:continue, [head|tail], starting_element, next_square) do
    Enum.at(head,starting_element) |> check_diagonal_tiles(tail, starting_element, next_square)
  end

  def check_diagonal_tiles(previous_element_value, [head | tail], element_to_check, next_square) do
    modified_element_to_check = next_square + element_to_check

    Enum.at(head,modified_element_to_check)
    |> String.contains?(previous_element_value)
    |> continue_diagonal_search?(previous_element_value, tail, modified_element_to_check, next_square)
  end

  def continue_diagonal_search?(true, _, [], _, _), do: :win

  def continue_diagonal_search?(true, previous_element_value, remaining_rows, element_to_check, next_square), do: check_diagonal_tiles(previous_element_value, remaining_rows, element_to_check, next_square)

  def continue_diagonal_search?(false, previous_element_value, remaining_rows, element_to_check, _), do: :continue

  def continue_diagonal_search?(false, previous_element_value, [], element_to_check), do: :continue

  def check_for_tied_board(:win, _), do: :win

  def check_for_tied_board(:continue, board) do
    List.flatten(board)
    |> MapSet.new()
    |> MapSet.size()
    |> board_is_tied
  end

  def board_is_tied(2), do: :tie

  def board_is_tied(_), do: :continue 
end
