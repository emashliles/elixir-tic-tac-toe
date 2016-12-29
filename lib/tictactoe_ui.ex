defmodule TicTacToe.UI do

  def start_game() do
    game_status =  TicTacToe.make_move()
    elem(game_status, 1)
    |> insert_new_lines_into_board()
    |> IO.puts 
    game_status
  end
  
  def get_move(game_status) do
     IO.gets("Please enter a tile selection:")
     |> String.trim()
     |> get_move(game_status)
  end

  def get_move(selected_tile, game_status) do 
    modified_board = TicTacToe.make_move(selected_tile, game_status)
    elem(modified_board, 1)
    |> insert_new_lines_into_board()
    |> IO.puts
    modified_board
  end

  def insert_new_lines_into_board(board) do
    board
    |> List.insert_at(3, "\n")
    |> List.insert_at(7, "\n") 
  end

end
