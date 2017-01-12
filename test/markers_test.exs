defmodule MarkersTests do
  use ExUnit.Case

  test "can find a list of all the available markers" do
    assert Markers.all == ["X","O"]
  end

  test "can find marker for a given player" do
    assert Markers.from_player_symbol(:x) == "X"
  end
end
