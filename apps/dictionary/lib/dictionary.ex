defmodule Dictionary do
  @moduledoc """
  Data module for the Hangman game.
  """
  alias Dictionary.Server

  @spec random_word() :: String.t()
  defdelegate random_word(), to: Server
end
