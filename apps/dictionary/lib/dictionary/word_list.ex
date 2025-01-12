defmodule Dictionary.WordList do
  @moduledoc """
  A module for managing the word list."
  """
  @type t :: MapSet.t(String.t())

  @spec word_list() :: t
  def word_list() do
    "assets/words.txt"
    |> File.read!()
    |> String.split(~r/\n/, trim: true)
    |> Enum.into(MapSet.new())
  end

  @spec random_word(t) :: String.t()
  def random_word(word_list) do
    word_list
    |> Enum.random()
  end
end
