defmodule WinOrTieCheckerTests do
  use ExUnit.Case

  import WinOrTieChecker 

  test "can detect a win if a row is taken by a player" do
    result = WinOrTieChecker.check_if_win_or_tie([["O","O","3"],["X","X","X"],["7","8","9"]])

    assert result == :win
  end

  test "retruns no_win_detected if none is found" do
    result = WinOrTieChecker.check_if_win_or_tie([["O","O","3"],["X","5","X"],["7","8","9"]])

    assert result == :continue
  end

  test "can detect a left to right diagonal win" do
    assert WinOrTieChecker.check_if_win_or_tie([["O","X","3"], ["X", "O", "6"], ["7", "X", "O"]]) == :win
  end

  test "can detect when final row is winning" do
    assert WinOrTieChecker.check_if_win_or_tie([["O","X","3"], ["X", "O", "6"], ["X", "X", "X"]]) == :win
  end

  test "can detect a right to left diagonal win" do
    assert WinOrTieChecker.check_if_win_or_tie([["O","X","X"], ["X", "X", "6"], ["X", "O", "O"]]) == :win
  end
end
