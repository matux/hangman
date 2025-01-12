defmodule Dictionary do
  @moduledoc """
  A module for managing the word list.
  """
  alias Dictionary.WordList

  @opaque t :: WordList.t()

  @spec start() :: t
  defdelegate start, to: WordList, as: :word_list

  @spec random_word(t) :: String.t()
  defdelegate random_word(word_list), to: WordList
end
