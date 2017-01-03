defmodule WinOrTieChecker do

  def check_if_win_or_tie(board) do
    check_for_winning_row(0,board)
    |> check_for_winning_diagonal(board, 0, 1)
    |> check_for_winning_diagonal(board, (length(board)- 1),-1)
  end

  def check_for_winning_row(1, _) do
    :win
  end

  def check_for_winning_row(x, []) do
    :no_win_detected
  end

  def check_for_winning_row(x, [head | tail]) do
    MapSet.new(head)
    |> MapSet.size()
    |> check_for_winning_row(tail)
  end

  def check_for_winning_diagonal(:win, _, _, _), do: :win

  def check_for_winning_diagonal(:no_win_detected, [head|tail], starting_element, next_square) do
    Enum.at(head,starting_element)
    |> check_diagonal_tiles(tail, starting_element, next_square)
  end

  def check_diagonal_tiles(previous_element_value, [head | tail], element_to_check, next_square) do
    modified_element_to_check = next_square + element_to_check
    Enum.at(head,modified_element_to_check)
    |> String.contains?(previous_element_value)
    |> continue_diagonal_search?(previous_element_value, tail, modified_element_to_check, next_square)
  end

  def continue_diagonal_search?(true, _, [], _, _) do
    :win
  end

  def continue_diagonal_search?(true, previous_element_value, remaining_rows, element_to_check, next_square) do
    check_diagonal_tiles(previous_element_value, remaining_rows, element_to_check, next_square)
  end

  def continue_diagonal_search?(false, previous_element_value, remaining_rows, element_to_check, _) do
    :no_win_detected
  end

  def continue_diagonal_search?(false, previous_element_value, [], element_to_check) do
    :no_win_detected
  end
end
