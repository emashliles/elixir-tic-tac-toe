defmodule BoardFormatterTest do
  use ExUnit.Case

  test "formats the board" do
    assert BoardFormatter.format_board([["1","2","3"], ["4","5","6"], ["7","8","9"]]) == [[" 1 ","|"," 2 ", "|"," 3 ", "\n"],["===========", "\n"],[" 4 ", "|"," 5 ", "|"," 6 ", "\n"],["===========", "\n"],[" 7 ", "|"," 8 ", "|"," 9 ", "\n"]]
  end

end
