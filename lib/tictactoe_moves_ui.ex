defmodule TicTacToe.Moves.UI do

  def get_player_move({_, board,_} = game_status) do
    selection = get_space_selection()

    if selection == :bad_input or selection > Board.size(board) do
      {:bad_input, game_status}
    else
      status = TicTacToe.make_move(selection - 1, game_status) 
      status
    end
  end

  def bad_input({player_symbol, _, _}= game_status) do
    player = Markers.from_player_symbol(player_symbol)
    IO.puts "Bad input. Player #{player}, please re-enter selection."
    game_status
  end

  def space_already_selected(game_status) do
    IO.puts "Space already selected. Please select a different space."
    game_status
  end

  def win({player_symbol, _, _}) do
    player_marker = Markers.from_player_symbol(player_symbol)
    IO.puts "Player #{player_marker} has won the game."
    :game_over
  end

  def tie do
    IO.puts "This game is a tie."
    :game_over
  end

  def replay? do
    replay_option = IO.gets("Play again? y/n\n")
    
    case String.trim(replay_option) do 
      "n" -> 
        IO.puts("Goodbye")
        false
      "y" -> true
      _ -> replay?
    end
  end

  def print_board({_, board, _}) do
    board
    |> BoardFormatter.format_board()
    |> IO.write
  end

  defp get_space_selection, do: IO.gets("Please enter a space selection: ")|> check_space_selection()

  def check_space_selection(selection) do
    try do
      String.trim(selection)
      |> String.to_integer()
      |> selection_is_negative()
    rescue
      ArgumentError -> :bad_input
      FunctionClauseError -> :bad_input
    end
  end

  defp selection_is_negative(selection) do
    if selection <= 0 do
      :bad_input
    else
      selection
    end
  end
end
