require Logger

defmodule Dictionary do
  def random_word do
    word_list()
      |> Enum.random
  end

  def word_list do
    "dictionary/assets/words.txt"
      |> File.read()
      |> process_file
  end

  def process_file({:ok, file}) do
    file
      |> String.split(~r/\n/)
  end

  def process_file({:error, reason}) do
    Logger.error("File error: #{reason}")
    []
  end

  def word_count, do: word_list() |> length
end
