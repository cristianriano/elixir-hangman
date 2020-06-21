defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def print_word(tally) do
    tally.letters |> Enum.join(" ")
  end
end
