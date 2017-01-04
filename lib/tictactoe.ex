defmodule TicTacToe do

  def make_move() do
    Board.create()
  end

  def make_move(selected_tile, game_status) do
    modified_game_status = Board.place_marker(selected_tile,game_status)
    change_player(modified_game_status, elem(modified_game_status,0), elem(modified_game_status,2))
  end

  def change_player(game_status, :o, :continue) do 
    {:x, elem(game_status, 1), :continue}
  end

  def change_player(game_status, :x, :continue) do 
    {:o ,elem(game_status, 1), :continue}
  end

  def change_player(game_status, player, :win) do
    {player,elem(game_status, 1), :win }
  end

  def change_player(game_status, player, :tie) do
    {player, elem(game_status, 1), :tie}
  end

  def change_player(game_status, player, :tile_already_selected) do
    {player, elem(game_status, 1), :tile_already_selected}
  end

end
