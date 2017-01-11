defmodule TicTacToe.UI do

  @clear_screen "\e[H\e[2J"

  def start_game_loop, do: start_game |> game_loop

  def start_game, do: TicTacToe.first_game_status |> do_next_turn

  def game_loop(:game_over), do: nil
  def game_loop(game_status) do
    game_status  
    |> get_move
    |> game_loop
  end

  def do_turn_type(turn_type, game_status) do
    IO.puts @clear_screen
    #print_board(game_status)

    case turn_type do
      :first_turn -> first_turn(game_status)
      :bad_input -> bad_input(game_status)
      :get_player_move -> do_turn(:get_player_move, game_status)
      :continue -> print_board_and_return_status(game_status)
      :tile_already_selected -> tile_already_selected(game_status)
      :win -> win(game_status)
      :tie -> tie(game_status)
      _ -> raise "turn type not found"
    end
  end

  def get_move(game_status), do: do_turn_type(:get_player_move, game_status)

  def make_move(selected_tile, game_status), do: TicTacToe.make_move(selected_tile, game_status)

  def do_next_turn({_,_,turn_type} = game_status) do
    do_turn_type(turn_type, game_status)
  end

  def print_board_and_return_status(game_status) do
    print_board(game_status)
    game_status
  end

  def do_turn(:get_player_move, {_, board,_} = game_status) do
    board_size = Board.size(board)
    selection = get_tile_selection()
    
    if selection == :bad_input or selection > board_size do
      do_turn_type(:bad_input, game_status)
    else
      make_move(selection, game_status)|> do_next_turn()
    end
  end

  def bad_input({player_symbol, _, _}= game_status) do
    player = Markers.get_player_marker(player_symbol)
    IO.puts @clear_screen
    IO.puts "Bad input. Player #{player}, please re-enter selection."
    print_board(game_status)
    do_turn(:get_player_move, game_status)
  end

  def first_turn(game_status) do
    print_board(game_status)
    game_status
  end

  def tile_already_selected(game_status) do
    IO.puts "Tile already selected. Please select a different tile."
    print_board(game_status)
    game_status
  end

  def win(game_status) do
    player_marker = get_marker_symbol(game_status)
    IO.puts "Player #{player_marker} has won the game."
    print_board(game_status)
    print_game_end_message
    :game_over
  end

  def tie(game_status) do
    IO.puts "This game is a tie."
    print_board(game_status)
    print_game_end_message
    :game_over
  end

  defp print_game_end_message, do: IO.puts "Goodbye."

  defp print_board({_, board, _}) do
    board
    |> format_board()
    |> IO.write
  end

  defp get_tile_selection, do: IO.gets("Please enter a tile selection: ")|> check_tile_selection()

  def check_tile_selection(selection) do
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

  defp add_spaces([head|tail], accumulator) do
    spaced_row = add_spaces_to_tiles_trailing(head)
    leading_spaced_row = add_spaces_to_tiles_leading(spaced_row)
    list = List.insert_at(accumulator, 100, leading_spaced_row)
    add_spaces(tail, list)
  end

  defp add_spaces_to_tiles_trailing(row) do
    Enum.map(row, fn(value) -> 
      String.pad_trailing(value, 2)
    end)
  end

  defp add_spaces_to_tiles_leading(row) do
    Enum.map(row, fn(value) -> 
      String.pad_leading(value, 3)
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

  defp insert_new_lines([head | tail], accumulator) do
    row_with_newline = List.insert_at(accumulator, -1,  head ++ ["\n"]) 
    insert_new_lines(tail, row_with_newline)
  end

  defp insert_new_lines([], accumulator), do: accumulator

  defp get_marker_symbol({player_symbol, _,_}), do: Markers.get_player_marker(player_symbol)

  defp get_chars_in_each_row(board) do
    List.first(board)
    |> List.to_string()
    |> String.length()
  end
end
