defmodule DictionaryTest do
  use ExUnit.Case
  doctest Dictionary

  test "provides a random word" do
    assert Dictionary.random_word() in Dictionary.word_list()
  end
end
