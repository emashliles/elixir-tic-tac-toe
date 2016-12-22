defmodule TicTacToe.UI do

  def start_game() do
    IO.puts TicTacToe.make_move()
  end
  
  def get_move() do
    IO.puts TicTacToe.make_move(String.trim(IO.gets("Please enter a tile selection:"))) 
  end

end
