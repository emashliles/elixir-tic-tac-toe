defmodule TicTacToe do

  def first_game_status do
    Board.create
  end

  def make_move(selected_tile, {player_symbol, board, _} = game_status) do
    tile_taken = Board.check_tile_not_taken(board, selected_tile)
    if tile_taken == :tile_already_selected do
      next_game_status({player_symbol, board, :tile_already_selected})
    else
      selected_tile
      |> Board.place_marker(game_status) 
      |> next_game_status()
    end
  end

  defp next_game_status({:o, board, :continue}), do: {:x, board, :continue}
  defp next_game_status({:x, board, :continue}), do: {:o ,board, :continue}
  defp next_game_status(game_status), do: game_status
end
