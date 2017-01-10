defmodule Markers do
 
  @markers [{:x, "X"},{:o, "O"}]

  def get_all_markers, do: Keyword.values(@markers)

  def get_player_marker(player_symbol), do: @markers[player_symbol]
end
