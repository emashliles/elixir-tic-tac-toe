defmodule TicTacToe.UI do

  @clear_screen "\e[H\e[2J"

  def start_game_loop, do: start_game |> game_loop

  def game_loop({_,_,:game_over}), do: nil
  def game_loop(game_status) do
    game_status  
    |> get_move()
    |> game_loop
  end

  def start_game, do: TicTacToe.first_game_status |> do_next_turn
  
  def get_move(game_status), do: do_turn(:get_player_move, game_status)

  def make_move(selected_tile, game_status), do: TicTacToe.make_move(selected_tile, game_status)

  def do_next_turn({_,_,turn_type} = game_status) do
    IO.puts @clear_screen
    do_turn(turn_type, game_status)
  end

  defp print_board({_, board, _}) do
    board
    |> format_board()
    |> IO.write
  end

  def do_turn(:continue, game_status) do
    print_board(game_status)
    game_status
  end

  def do_turn(:get_player_move, {player_symbol, board,_} = game_status) do
    board_size = Board.size(board)
    selection = get_tile_selection()
    player = Markers.get_player_marker(player_symbol)
    
    if selection == :bad_input or selection > board_size do
      IO.puts @clear_screen
      IO.puts "Bad input. Player #{player}, please re-enter selection."
      print_board(game_status)
      do_turn(:get_player_move, game_status)
    else
      make_move(selection, game_status)|> do_next_turn()
    end
  end

  def do_turn(:first_turn, game_status) do
    print_board(game_status)
    game_status
  end

  def do_turn(:tile_already_selected, game_status) do
    IO.puts "Tile already selected. Please select a different tile."
    print_board(game_status)
    game_status
  end

  def do_turn(:win, game_status) do
    player_marker = get_marker_symbol(game_status)
    IO.puts "Player #{player_marker} has won the game."
    print_board(game_status)
    print_game_end_message
    {1,2,:game_over}
  end

  def do_turn(:tie, game_status) do
    IO.puts "This game is a tie."
    print_board(game_status)
    print_game_end_message
    {:player,:board,:game_over}
  end

  defp print_game_end_message, do: IO.puts "Goodbye."


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
    spaced_board = add_spaces([], board)
    board_with_lines = add_lines([], spaced_board)
    board_with_row_separator = add_separators(board_with_lines)
    insert_new_lines_into_board([], board_with_row_separator)
  end

  defp add_spaces(accumulator, []), do: accumulator

  defp add_spaces(accumulator, [head|tail]) do
    spaced_row = add_spaces_to_tiles(head)
    leading_spaced_row = add_spaces_to_tiles_leading(spaced_row)
    List.insert_at(accumulator, 100, leading_spaced_row) |> add_spaces(tail)
  end

  defp add_spaces_to_tiles(row) do
    Enum.map(row, fn(value) -> 
      String.pad_trailing(value, 2)
    end)
  end

  defp add_spaces_to_tiles_leading(row) do
    Enum.map(row, fn(value) -> 
      String.pad_leading(value, 3)
    end)
  end
  defp add_lines(accumulator, []), do: accumulator

  defp add_lines(accumulator,[head | tail]) do
    accumulator ++  [Enum.intersperse(head, "|")]|> add_lines(tail)
  end

  defp add_separators(board) do
    row_length = get_chars_in_each_row(board)
    separator =  String.duplicate("=", row_length)
    Enum.intersperse(board, [separator])
  end

  defp insert_new_lines_into_board(formatted_rows,[head | tail]) do
    List.insert_at(formatted_rows, -1,  head ++ ["\n"]) 
    |> insert_new_lines_into_board(tail)
  end

  defp insert_new_lines_into_board(formatted_rows, []), do: formatted_rows

  defp get_marker_symbol({player_symbol, _,_}), do: Markers.get_player_marker(player_symbol)

  defp get_chars_in_each_row(board) do
    List.first(board)
    |> List.to_string()
    |> String.length()
  end
end
