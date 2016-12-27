defmodule TicTacToe.UI do

  def start_game() do
  board =  TicTacToe.make_move()
  elem(board, 1)
  |> insert_new_lines_into_board()
  |> IO.puts 
  board
  end
  
  def get_move(board) do
     IO.gets("Please enter a tile selection:")
     |> String.trim()
     |> get_move(board)
  end

  def get_move(selected_tile, board) do 
    modified_board = TicTacToe.make_move(selected_tile, board)
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
