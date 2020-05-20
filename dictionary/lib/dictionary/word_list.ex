require Logger

defmodule Dictionary.WordList do

  def word_list() do
    "../../assets/words.txt"
      |> Path.expand(__DIR__)
      |> File.read()
      |> process_file
  end

  def random_word(words) do
    words
      |> Enum.random
  end

  defp process_file({:ok, file}) do
    file
      |> String.split(~r/\n/)
  end

  defp process_file({:error, reason}) do
    Logger.error("File error: #{reason}")
    []
  end
end
