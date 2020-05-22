defmodule Fib do
  def fib(n) do
    { :ok, cache } = CachedFib.start
    calculate(cache, n)
  end

  defp calculate(cache, n) do
    calculate_fib(cache, n, CachedFib.calculated?(cache, n))
  end

  defp calculate_fib(cache, n, _already_calculated = true) do
    CachedFib.get(cache, n)
  end

  defp calculate_fib(cache, n, _not_calculated) do
    CachedFib.add(cache, n, calculate(cache, n-2) + calculate(cache, n-1))
  end
end

defmodule CachedFib do
  def start() do
    Agent.start_link(fn -> %{ 0 => 0, 1 => 1 } end)
  end

  def calculated?(agent, n) do
    Agent.get(agent, &(Map.has_key?(&1, n)))
  end

  def get(agent, n) do
    Agent.get(agent, &(&1[n]))
  end

  def add(agent, n, value) do
    Agent.get_and_update(agent, &{ value, Map.put(&1, n, value) })
  end
end
