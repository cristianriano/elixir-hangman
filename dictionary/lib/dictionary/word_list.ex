require Logger

defmodule Dictionary.WordList do

  # Module attribute (like constant) with the name of the module
  @me __MODULE__

  def start_link() do
    Agent.start_link(&word_list/0, name: @me)
  end

  def random_word() do
    Agent.get(@me, &Enum.random/1)
  end

  defp word_list() do
    "../../assets/words.txt"
      |> Path.expand(__DIR__)
      |> File.read()
      |> process_file
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
