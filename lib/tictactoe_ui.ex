defmodule TicTacToe.UI do

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
    TicTacToe.make_move()
    |> decide_turn_type()
  end
  
  def get_move(game_status) do
    #unless elem(game_status, 2) == :game_over do
      print_turn(:get_player_move, game_status)
      # end
  end

  def get_tile_selection() do
    IO.gets("Please enter a tile selection:")
    |> String.trim()
    |> String.to_integer()
  end

  def make_move(selected_tile, game_status) do 
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
    |> make_move(game_status)
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
    print_game_end_message
    {1,2,:game_over}
  end

  def print_turn(:tie, game_status) do
    IO.puts "This game is a tie."
    print_board(game_status)
    print_game_end_message
  end

  def print_game_end_message(), do: IO.puts "Goodbye."

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
