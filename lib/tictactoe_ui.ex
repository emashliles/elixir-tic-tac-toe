defmodule TicTacToe.UI do

  @clear_screen "\e[H\e[2J"

  def start_game_loop, do: start_game |> game_loop

  def start_game do 
    status = TicTacToe.first_game_status
    IO.puts @clear_screen
    TicTacToe.Moves.UI.print_board(status)
    status
  end

  def game_loop(:game_over) do
    if TicTacToe.Moves.UI.replay? do
      start_game_loop
    end
  end
  def game_loop(game_status) do
    game_status
    |> do_turn
    |> game_loop
  end

  def do_turn(game_status) do
    game_status
    |> TicTacToe.Moves.UI.get_player_move
    |> do_turn_type
  end

  def do_turn_type({_,_,turn} = game_status), do: do_turn_type(turn, game_status)
  def do_turn_type({turn_type, game_status}), do: do_turn_type(turn_type, game_status)
  def do_turn_type(turn_type, game_status) do
    IO.puts @clear_screen
    TicTacToe.Moves.UI.print_board(game_status)

    case turn_type do
      :get_player_move -> TicTacToe.Moves.UI.get_player_move(game_status)
      :continue -> game_status
      :space_already_selected -> TicTacToe.Moves.UI.space_already_selected(game_status)
      :win -> TicTacToe.Moves.UI.win(game_status)
      :tie -> TicTacToe.Moves.UI.tie()
      :bad_input -> TicTacToe.Moves.UI.bad_input(game_status)
      _ -> raise "turn type not found"
    end
  end

end
