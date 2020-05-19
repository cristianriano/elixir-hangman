defmodule TextClient do
  alias TextClient.Interface

  defdelegate start(), to: Interface
end
