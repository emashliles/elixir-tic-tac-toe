defmodule TicTacToe.UI do

  @clear_screen "\e[H\e[2J"

  def start_game_loop, do: start_game |> game_loop

  def start_game do 
    status = TicTacToe.first_game_status
    IO.puts @clear_screen
    print_board(status)
    status
  end

  def game_loop(:game_over), do: nil
  def game_loop(game_status) do
    game_status
    |> do_turn
    |> game_loop
  end

  def do_turn(game_status) do
    game_status
    |> get_player_move
    |> do_turn_type
  end


  def do_turn_type(:game_over), do: :game_over
  def do_turn_type( {_,_,turn} = game_status), do: do_turn_type(turn, game_status)
  def do_turn_type({turn_type, game_status}), do: do_turn_type(turn_type, game_status)
  def do_turn_type(turn_type, game_status) do
    IO.puts @clear_screen
    print_board(game_status)

    case turn_type do
      :get_player_move -> get_player_move(game_status)
      :continue -> game_status
      :space_already_selected -> space_already_selected(game_status)
      :win -> win(game_status)
      :tie -> tie()
      :bad_input -> bad_input(game_status)
      _ -> raise "turn type not found"
    end
  end

  def get_player_move({_, board,_} = game_status) do
    selection = get_space_selection()

    if selection == :bad_input or selection > Board.size(board) do
      {:bad_input, game_status}
    else
      status = TicTacToe.make_move(selection - 1, game_status) 
      status
    end
  end

  def bad_input({player_symbol, _, _}= game_status) do
    player = Markers.from_player_symbol(player_symbol)
    IO.puts "Bad input. Player #{player}, please re-enter selection."
    game_status
  end

  def space_already_selected(game_status) do
    IO.puts "Space already selected. Please select a different space."
    game_status
  end

  def win({player_symbol, _, _}) do
    player_marker = Markers.from_player_symbol(player_symbol)
    IO.puts "Player #{player_marker} has won the game."
    print_game_end_message
    :game_over
  end

  def tie() do
    IO.puts "This game is a tie."
    print_game_end_message
    :game_over
  end

  defp print_game_end_message, do: IO.puts "Goodbye."

  defp print_board({_, board, _}) do
    board
    |> format_board()
    |> IO.write
  end

  defp get_space_selection, do: IO.gets("Please enter a space selection: ")|> check_space_selection()

  def check_space_selection(selection) do
    try do
      String.trim(selection)
      |> String.to_integer()
      |> selection_is_negative()
    rescue
      ArgumentError -> :bad_input
      FunctionClauseError -> :bad_input
    end
  end

  defp selection_is_negative(selection) do
    if selection <= 0 do
      :bad_input
    else
      selection
    end
  end

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
