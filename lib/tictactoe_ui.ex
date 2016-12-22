defmodule TicTacToe.UI do

  def start_game() do
    TicTacToe.make_move()
    |> IO.puts 
  end
  
  def get_move() do
    "Please enter a tile selection:"
    |> IO.gets()
    |> String.trim()
    |> TicTacToe.make_move() 
    |> IO.puts
  end
end
