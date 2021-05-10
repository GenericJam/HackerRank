defmodule Solution5 do
  @moduledoc """
  Return minimum number of swaps to go from "))()(()(" > "()()(())" = 1

  good = "()()(())"
  fix = ")))()(()(("

  Sample Input

  ")))()(()(("

  Sample Output

  2

  Run like this:
  iex>Solution5.input() |> Solution5.show()
  )))()(()((
  2
  """

  def balanced(brackets) do
    cond do
      balance(brackets |> String.to_charlist()) != 0 ->
        -1

      true ->
        brackets |> String.to_charlist() |> on_balance(0)
    end
  end

  def balance([]) do
    0
  end

  def balance([41 | t]) do
    balance(t) + 1
  end

  def balance([40 | t]) do
    balance(t) - 1
  end

  def on_balance([], 0) do
    true
  end

  # If it's a ) in this position it will fail
  def on_balance([41 | _t], 0) do
    false
  end

  def on_balance([41 | t], sum) do
    on_balance(t, sum + 1)
  end

  def on_balance([40 | t], sum) do
    on_balance(t, sum - 1)
  end

  def fix_one(brackets) do
    cand = move_candidates(brackets |> String.to_charlist(), 0, 0, %{}) |> Enum.into([])

    {right_index, _} = Enum.find(cand, fn {_k, v} -> v == 41 end)
    {left_index, _} = Enum.find(cand |> Enum.reverse(), fn {_k, v} -> v == 40 end)

    begin =
      if(right_index > 0) do
        String.slice(brackets, 0..(right_index - 1))
      else
        ""
      end

    begin <>
      "(" <>
      String.slice(brackets, (right_index + 1)..(left_index - 1)) <>
      ")" <> String.slice(brackets, (left_index + 1)..String.length(brackets))
  end

  def move_candidates([], _sum, _position, candidates) do
    candidates
  end

  def move_candidates([41 | t], sum, position, candidates) when sum >= 0 do
    move_candidates(t, sum + 1, position + 1, Map.merge(candidates, %{position => 41}))
  end

  def move_candidates([41 | t], sum, position, candidates) do
    move_candidates(t, sum + 1, position + 1, candidates)
  end

  def move_candidates([40 | t], 1, position, candidates) do
    move_candidates(t, 0, position + 1, Map.merge(candidates, %{position => 40}))
  end

  def move_candidates([40 | t], sum, position, candidates) do
    move_candidates(t, sum - 1, position + 1, candidates)
  end

  def iter(brackets, attempts \\ 0) do
    case balanced(brackets) do
      true ->
        attempts

      -1 ->
        -1

      false ->
        brackets |> fix_one() |> iter(attempts + 1)
    end
  end

  def show(input) do
    iter(input) |> IO.puts()
  end

  def input do
    IO.read(:stdio, :line)
    |> String.trim()
  end
end
