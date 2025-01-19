defmodule Dictionary.Server do
  @moduledoc """
  A module for managing the word list.
  """
  @type t :: pid()

  use Agent

  alias Dictionary.WordList

  def start_link(_) do
    Agent.start_link(&WordList.word_list/0, name: __MODULE__)
  end

  def random_word() do
    if :rand.uniform() < 0.33 do
      Agent.get(__MODULE__, fn _ -> exit(:boom) end)
    end

    Agent.get(__MODULE__, &WordList.random_word/1)
  end
end
