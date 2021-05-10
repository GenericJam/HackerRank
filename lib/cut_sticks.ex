defmodule Solution3 do
  @moduledoc """
  You are given a number of sticks of varying lengths. You will iteratively cut the sticks into smaller sticks,
  discarding the shortest pieces until there are none left. At each iteration you will determine the length of
  the shortest stick remaining, cut that length from each of the longer sticks and then discard all the pieces of
  that shortest length. When all the remaining sticks are the same length, they cannot be shortened so discard them.

  Given the lengths of n sticks, print the number of sticks that are left before each iteration until there are none left.

  Sample Input

  6               arr[] size n = 6
  5 4 4 2 2 8     arr = [5, 4, 4, 2, 2, 8]

  Sample Output
  6
  4
  2
  1


  Run like this:
  iex>Solution3.input() |> Solution3.show()
  6
  5 4 4 2 2 8
  6
  4
  2
  1
  :ok
  """

  def iter([]) do
    []
  end

  def iter(list) do
    first = list |> Enum.at(0)
    new_list = list |> Enum.reject(&(&1 == first)) |> Enum.map(&(&1 - first))

    [length(list) | iter(new_list)]
  end

  def show(input) do
    Enum.each(iter(input |> Enum.sort(&(&1 < &2))), &IO.puts(&1))
  end

  def input do
    _array_length = IO.read(:stdio, :line)

    IO.read(:stdio, :line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&(&1 |> String.to_integer()))
  end
end
