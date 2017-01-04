defmodule TicTacToe.UI do

  def start_game() do
    TicTacToe.make_move()
    |> decide_turn_type()
  end
  
  def get_move(game_status) do
    print_turn(:get_player_move,game_status) 
  end

  def get_tile_selection() do
    IO.gets("Please enter a tile selection:")
    |> String.trim()
    |> String.to_integer()
  end

  def make_and_print_move(selected_tile, game_status) do 
    TicTacToe.make_move(selected_tile, game_status)
  end

   def decide_turn_type(game_status) do
     elem(game_status, 2)
     |> print_turn(game_status)
   end

  def print_turn(:continue, game_status) do
    print_board(game_status)
    game_status
  end

  def print_turn(:get_player_move, game_status) do
    get_tile_selection()
    |> make_and_print_move(game_status)
    |> decide_turn_type()
  end

  def print_turn(:first_turn, game_status) do
    print_board(game_status)
    game_status
  end

  def print_turn(:tile_already_selected, game_status) do
    IO.puts "Tile already selected. Please select a different tile."
    print_board(game_status)
  end

  def print_turn(:win, game_status) do
    player_marker = get_marker_symbol(elem(game_status, 0))
    IO.puts "Player #{player_marker} has won the game."
    print_board(game_status)
  end

  def print_board(game_status) do
    elem(game_status, 1)
    |> format_board()
    |> IO.write
    game_status
  end

  def format_board(board) do
    insert_new_lines_into_board([], board)
  end

  def insert_new_lines_into_board(formatted_rows,[head | tail]) do
    List.insert_at(formatted_rows, -1,  head ++ ["\n"]) 
    |> insert_new_lines_into_board(tail)
  end

  def insert_new_lines_into_board(formatted_rows, []) do
    formatted_rows
  end

  def get_marker_symbol(player_symbol) do
    available_markers = [{:x,"X" },{:o, "O"}]
    available_markers[player_symbol]
  end

end
