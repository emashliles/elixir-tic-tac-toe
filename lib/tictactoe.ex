defmodule TicTacToe do

  def create_game_status do
    Board.create
  end

  def make_move(selected_tile, game_status) do
    tile_taken = Board.check_tile_not_taken(elem(game_status, 1), selected_tile, :x)
    if tile_taken == :tile_already_selected do
      create_new_game_status(game_status, elem(game_status, 0), :tile_already_selected)
    else
      modified_game_status = Board.place_marker(selected_tile,game_status)
      create_new_game_status(modified_game_status, elem(modified_game_status,0), elem(modified_game_status,2))
    end
  end

  def create_new_game_status({_, board, _}, :o, :continue), do: {:x, board, :continue}
  def create_new_game_status({_, board, _}, :x, :continue), do: {:o ,board, :continue}
  def create_new_game_status({_, board, _}, player, result),  do: {player, board,result }

end
