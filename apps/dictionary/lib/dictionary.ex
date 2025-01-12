defmodule Dictionary do
  # compile-time attribute
  @word_list "assets/words.txt"
             |> File.read!()
             |> String.split(~r/\n/, trim: true)

  def random_word do
    @word_list
    |> Enum.random()
  end

  def word_list, do: @word_list
end
