defmodule TicTacToe.UI do

  @clear_screen "\e[H\e[2J"

  def start_game_loop() do
    start_game()
    |> game_loop
  end

  def game_loop(game_status) do
    unless elem(game_status, 2) == :game_over do
      get_move(game_status)
      |> game_loop
    end
  end

  def start_game() do
    TicTacToe.create_game_status()
    |> do_next_turn()
  end
  
  def get_move(game_status) do
      do_turn(:get_player_move, game_status)
  end

  def make_move(selected_tile, game_status) do 
    TicTacToe.make_move(selected_tile, game_status)
  end

  def do_next_turn(game_status) do
    IO.puts @clear_screen

    elem(game_status, 2)
    |> do_turn(game_status)
  end

  def do_turn(:continue, game_status) do
    print_board(game_status)
    game_status
  end

  def do_turn(:get_player_move, game_status) do
    board_size = get_board_size(game_status)
    selection = get_tile_selection()
    player = get_marker_symbol(game_status)
    
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

  def print_game_end_message(), do: IO.puts "Goodbye."

  def print_board(game_status) do
    elem(game_status, 1)
    |> format_board()
    |> IO.write
    game_status
  end

  def get_tile_selection() do
    IO.gets("Please enter a tile selection: ")
    |> check_tile_selection()
  end

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

  def selection_is_negative(selection) do
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

  def add_spaces(accumulator, []) do
    accumulator
  end

  def add_spaces(accumulator, [head|tail]) do
    spaced_row = add_spaces_to_tiles(head)
    leading_spaced_row = add_spaces_to_tiles_leading(spaced_row)
    List.insert_at(accumulator, 100, leading_spaced_row) |> add_spaces(tail)
  end

  def add_spaces_to_tiles(row) do
    Enum.map(row, fn(value) -> 
      String.pad_trailing(value, 2)
    end)
  end

  def add_spaces_to_tiles_leading(row) do
    Enum.map(row, fn(value) -> 
      String.pad_leading(value, 3)
    end)
  end
  def add_lines(accumulator, []), do: accumulator

  def add_lines(accumulator,[head | tail]) do
   accumulator ++  [Enum.intersperse(head, "|")]|> add_lines(tail)
  end

  def add_separators(board) do
    separator = ["==========="]
    Enum.intersperse(board, separator)
  end

  def insert_new_lines_into_board(formatted_rows,[head | tail]) do
    List.insert_at(formatted_rows, -1,  head ++ ["\n"]) 
    |> insert_new_lines_into_board(tail)
  end

  def insert_new_lines_into_board(formatted_rows, []), do: formatted_rows

  def get_marker_symbol(game_status) do
    elem(game_status, 0) |> Markers.get_player_marker()
  end

  def get_board_size(game_status) do
    elem(game_status, 1)
    |> List.flatten()
    |> length
  end
end
