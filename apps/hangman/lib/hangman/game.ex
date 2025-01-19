defmodule Hangman.Game do
  @moduledoc """
  The game implementation.
  """
  alias Hangman.Type

  @type t :: %__MODULE__{
          turns_left: integer,
          game_state: Type.state(),
          letters: list(String.t()),
          used: MapSet.t(String.t())
        }

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  @spec new_game() :: t
  def new_game do
    new_game(Dictionary.random_word())
  end

  @spec new_game(String.t()) :: t
  def new_game(word) do
    %__MODULE__{
      letters: word |> String.codepoints()
    }
  end

  @spec guess(t, String.t()) :: {t, Type.tally()}
  def guess(game = %{game_state: state}, _)
      when state in [:won, :lost] do
    game |> return_with_tally()
  end

  def guess(game, guess) do
    accept_guess(game, guess, MapSet.member?(game.used, guess))
    |> return_with_tally()
  end

  @spec tally(t) :: Type.tally()
  def tally(game) do
    %{
      turns_left: game.turns_left,
      game_state: game.game_state,
      letters: reveal_guessed_letters(game),
      used: game.used |> MapSet.to_list() |> Enum.sort()
    }
  end

  ##############################################################################

  defp accept_guess(game, _guess, _already_used = true) do
    %{game | game_state: :duplicate_guess}
  end

  defp accept_guess(game, guess, _not_used) do
    %{game | used: MapSet.put(game.used, guess)}
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(game, _good_guess = true) do
    %{
      game
      | game_state:
          game.letters
          |> MapSet.new()
          |> MapSet.subset?(game.used)
          |> won_or_good_guess()
    }
  end

  defp score_guess(game = %{turns_left: 1}, _bad_guess) do
    %{game | game_state: :lost, turns_left: 0}
  end

  defp score_guess(game, _bad_guess) do
    %{game | game_state: :bad_guess, turns_left: game.turns_left - 1}
  end

  defp return_with_tally(game) do
    {game, tally(game)}
  end

  defp reveal_guessed_letters(game = %{game_state: :lost}) do
    game.letters
  end

  defp reveal_guessed_letters(game) do
    game.letters
    |> Enum.map(fn letter -> MapSet.member?(game.used, letter) |> maybe_reveal(letter) end)
  end

  defp won_or_good_guess(true), do: :won
  defp won_or_good_guess(false), do: :good_guess

  defp maybe_reveal(true, letter), do: letter
  defp maybe_reveal(_, _letter), do: "_"
end
