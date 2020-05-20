defmodule WordListTest do
  use ExUnit.Case

  alias Dictionary.WordList

  test "start returns a list of words" do
    words = WordList.word_list()

    assert is_list(words) == true
  end

  test "random_word returns a lower case word" do
    word = WordList.word_list() |> WordList.random_word()

    assert (word =~ ~r/[a-z]+/) == true
  end
end
