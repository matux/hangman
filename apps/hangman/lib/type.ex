defmodule Hangman.Type do
  @moduledoc """
  The types used in the Hangman game.
  """
  @type state :: :initializing | :won | :lost | :good_guess | :bad_guess | :duplicate_guess
  @type tally :: %{
          turns_left: integer,
          game_state: state,
          letters: list(String.t()),
          used: list(String.t())
        }
end
