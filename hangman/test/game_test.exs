defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "new_game letters are all ASCII characters" do
    letters = Game.new_game().letters
    regex = ~r/[a-z]/

    letters
      |> Enum.each(fn x -> assert(Regex.match?(regex, x)) end)
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert { ^game, _ } = Game.make_move(game, "a")
    end
  end

  test "first occurrence of letter is not marked as already_used" do
    { game, _tally } = Game.new_game() |> Game.make_move("x")
    assert game.game_state != :already_used
  end

  test "later occurrence of letter is marked as already_used" do
    { game, _tally } = Game.new_game() |> Game.make_move("x")
    assert game.game_state != :already_used

    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    { game, _tally } = Game.new_game("yes") |> Game.make_move("y")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won" do
    { game, _tally } = Game.new_game("yes") |> Game.make_move("y")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    { game, _tally } = Game.make_move(game, "e")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    { game, _tally } = Game.make_move(game, "s")
    assert game.game_state == :won
    assert game.turns_left == 7
  end
end
