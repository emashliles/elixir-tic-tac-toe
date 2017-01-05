defmodule TicTacToe do

  def create_game_status() do
    Board.create()
  end

  def make_move(selected_tile, game_status) do
    modified_game_status = Board.place_marker(selected_tile,game_status)
    create_new_game_status(modified_game_status, elem(modified_game_status,0), elem(modified_game_status,2))
  end

  def create_new_game_status(game_status, :o, :continue), do: {:x, elem(game_status, 1), :continue}

  def create_new_game_status(game_status, :x, :continue), do: {:o ,elem(game_status, 1), :continue}

  def create_new_game_status(game_status, player, :win), do: {player,elem(game_status, 1), :win }

  def create_new_game_status(game_status, player, :tie), do: {player, elem(game_status, 1), :tie}

  def create_new_game_status(game_status, player, :tile_already_selected), do: {player, elem(game_status, 1), :tile_already_selected}

end
