defmodule Solution1 do
  @moduledoc """
  Watson likes to challenge Sherlock's math ability. He will provide a starting
  and ending value that describe a range of integers, inclusive of the endpoints.
  Sherlock must determine the number of square integers within that range.

  Note: A square integer is an integer which is the square of an integer, e.g. 1, 4, 9, 16

  Sample Input

  2
  3 9
  17 24

  Sample Output

  2
  0

  Run like this:
  iex>Solution1.input() |> Solution1.process()
  2
  3 9
  17 24
  2
  0
  :ok
  """
  def squares(lower, upper) do
    squares(1, 1, 0, lower, upper)
  end

  defp squares(odd, square, 0, lower, upper) when square < lower do
    squares(odd + 2, square + odd + 2, 0, lower, upper)
  end

  defp squares(odd, square, count, lower, upper) when square <= upper do
    squares(odd + 2, square + odd + 2, count + 1, lower, upper)
  end

  defp squares(_sum, _square, count, _lower, _upper) do
    count
  end

  def iter([]) do
    []
  end

  def iter([[lower, upper] | t]) do
    [squares(lower, upper) | iter(t)]
  end

  def process(list) do
    iter(list) |> Enum.each(&IO.puts(&1))
  end

  def input do
    array_length = IO.read(:stdio, :line)

    expect_inputs =
      array_length
      |> String.trim()
      |> String.to_integer()

    inputs =
      1..expect_inputs
      |> Enum.map(fn _ ->
        IO.read(:stdio, :line)
        |> String.trim()
        |> String.split(" ")
        |> Enum.map(&(&1 |> String.to_integer()))
      end)

    inputs
  end
end
