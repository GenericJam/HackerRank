defmodule Solution4 do
  @moduledoc """
  You start out with some money and the price of a chocolate bar and how many wrappers you need to turn to
  get another chocolate bar. Figure out how many chocolate bars you end up with.

  Do this in succession.

  Sample Input

  3       t = 3 (test cases)
  10 2 5  n = 10, c = 2, m = 5 (first test case)
  12 4 4  n = 12, c = 4, m = 4 (second test case)
  6 2 2   n = 6,  c = 2, m = 2 (third test case)

  Sample Output
  6
  3
  5

  Run like this:
  iex>Solution4.input() |> Solution4.show()
  3
  10 2 5
  12 4 4
  6 2 2
  6
  3
  5
  :ok
  """

  def iter([]) do
    []
  end

  def iter([[money, cost, wrapper_threshold] | t]) do
    ans = compute(money, cost, wrapper_threshold)
    [ans | iter(t)]
  end

  def compute(money, cost, wrapper_threshold) do
    bars = div(money, cost)
    bars + bars_for_wrappers(bars, wrapper_threshold)
  end

  def bars_for_wrappers(wrappers, wrapper_threshold) when wrappers >= wrapper_threshold do
    bars = div(wrappers, wrapper_threshold)
    bars + bars_for_wrappers(rem(wrappers, wrapper_threshold) + bars, wrapper_threshold)
  end

  def bars_for_wrappers(_wrappers, _wrapper_threshold) do
    0
  end

  def show(input) do
    Enum.each(iter(input), &IO.puts(&1))
  end

  def input do
    array_length = IO.read(:stdio, :line)

    expect_inputs =
      array_length
      |> String.trim()
      |> String.to_integer()

    1..expect_inputs
    |> Enum.map(fn _ ->
      IO.read(:stdio, :line)
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(&(&1 |> String.to_integer()))
    end)
  end
end
