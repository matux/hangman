defmodule Hangman do
  @moduledoc """
  Coding Gnome elixir for programmers book
  """
  alias Hangman.Game
  alias Hangman.Type

  @opaque game :: Game.t()

  @spec new_game() :: game
  defdelegate new_game(), to: Game

  @spec guess(game, String.t()) :: {game, Type.tally()}
  defdelegate guess(game, guess), to: Game

  @spec tally(game) :: Type.tally()
  defdelegate tally(game), to: Game
end
