defmodule TicTacToe.UI do

  def start_game() do
  board =  TicTacToe.make_move()
  insert_new_lines_into_board(board)
  |> IO.puts 
  board
  end
  
  def get_move(board) do
     get_move(String.trim(IO.gets( "Please enter a tile selection:")),board)
     |> IO.puts
  end

  def get_move(selected_tile, board) do 
    TicTacToe.make_move(selected_tile, board)
    |> insert_new_lines_into_board()
  end

  def insert_new_lines_into_board(board) do
    board
    |> List.insert_at(3, "\n")
    |> List.insert_at(7, "\n") 
  end
end
