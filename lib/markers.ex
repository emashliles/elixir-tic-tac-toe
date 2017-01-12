defmodule Markers do
 
  @markers [{:x, "X"},{:o, "O"}]

  def all, do: Keyword.values(@markers)

  def from_player_symbol(player_symbol), do: @markers[player_symbol]

end
