defmodule Dictionary.Server do
  @moduledoc """
  A module for managing the word list.
  """
  @type t :: pid()

  alias Dictionary.WordList

  def start_link do
    Agent.start_link(&WordList.word_list/0)
  end

  def random_word(pid) do
    Agent.get(pid, &WordList.random_word/1)
  end
end
