defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "it can retrun and empty board" do
    assert TicTacToe.make_move() == {:x, ["1","2","3","4","5","6","7","8","9"], :first_turn}
  end

  test "player can select tile 5" do
    assert TicTacToe.make_move(5,{:x,["1","2","3","4","5","6","7","8","9"], :continue}) == {:o,["1","2","3","4","X","6","7","8","9"], :continue}   
  end

  test "player can select tile 9" do
    assert TicTacToe.make_move(9,{:x,["1","2","3","4","5","6","7","8","9"], :continue}) == {:o, ["1","2","3","4","5","6","7","8","X"], :continue} 
  end

  test "player can select tile 1" do
    assert TicTacToe.make_move(1,{:x, ["1","2","3","4","5","6","7","8","9"], :continue}) == {:o, ["X","2","3","4","5","6","7","8","9"], :continue} 
  end
  
  test "a different player can select a tile" do
    assert TicTacToe.make_move(1,{:o,["1","2","3","4","X","6","7","8","9"], :continue}) == {:x, ["O","2","3","4","X","6","7","8","9"], :continue}
  end

  test "tiles cannot be selected twice" do
    assert TicTacToe.make_move(1,{:o,["O","2","3","4","X","6","7","8","9"],:continue}) == {:o, ["O","2","3","4","X","6","7","8","9"],:tile_already_selected}
  end
end
