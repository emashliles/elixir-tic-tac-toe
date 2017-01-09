defmodule MarkersTests do
  use ExUnit.Case

  test "it can find a list of all the available markers" do
    assert Markers.get_all_markers == ["X","O"]
  end

  test "it can find marker for a given player" do
    assert Markers.get_player_marker(:x) == "X"
  end
end