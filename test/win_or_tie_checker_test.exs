defmodule WinOrTieCheckerTests do
  use ExUnit.Case

  test "can detect a win if a row is taken by a player" do
    assert WinOrTieChecker.evaluate([["O","O","3"],["X","X","X"],["7","8","9"]]) == :win
  end

  test "can detect when final row is winning" do
    assert WinOrTieChecker.evaluate([["O","X","3"], ["X", "O", "6"], ["X", "X", "X"]]) == :win
  end

  test "retruns no_win_detected if none is found" do
    assert WinOrTieChecker.evaluate([["O","O","3"],["X","5","X"],["7","8","9"]])  == :continue
  end

  test "can detect a left to right diagonal win" do
    assert WinOrTieChecker.evaluate([["O","X","3"], ["X", "O", "6"], ["7", "X", "O"]]) == :win
  end

  test "can detect a right to left diagonal win" do
    assert WinOrTieChecker.evaluate([["O","X","X"], ["X", "X", "6"], ["X", "O", "O"]]) == :win
  end

  test "can detect a win if player takes a column" do
    assert WinOrTieChecker.evaluate([["1","2","X"], ["4", "O", "X"], ["O", "O", "X"]]) == :win
  end

  test "can detect a tie" do
    assert WinOrTieChecker.evaluate([["O", "O", "X"], ["X", "X", "O",], ["O", "X", "O"]]) == :tie
  end

end
