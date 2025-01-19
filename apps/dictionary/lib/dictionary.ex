defmodule Dictionary do
  @moduledoc """
  A module for managing the word list.
  """
  alias Dictionary.Server

  @spec random_word() :: String.t()
  defdelegate random_word(), to: Server
end
