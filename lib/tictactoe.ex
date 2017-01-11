defmodule TicTacToe do

  def create_game_status do
    Board.create
  end

  def make_move(selected_tile, {player_symbol, board, _} = game_status) do
    tile_taken = Board.check_tile_not_taken(board, selected_tile)
    if tile_taken == :tile_already_selected do
      create_new_game_status({player_symbol, board, :tile_already_selected})
    else
      selected_tile
      |> Board.place_marker(game_status) 
      |> create_new_game_status()
    end
  end

  defp create_new_game_status({:o, board, :continue}), do: {:x, board, :continue}
  defp create_new_game_status({:x, board, :continue}), do: {:o ,board, :continue}
  defp create_new_game_status(game_status), do: game_status
end
