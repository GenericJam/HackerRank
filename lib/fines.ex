defmodule Solution2 do
  @moduledoc """
  Your local library needs your help! Given the expected and actual return dates for a library book,
  create a program that calculates the fine (if any).

  Sample Input

  9 6 2015
  6 6 2015

  Sample Output
  45


  Run like this:
  iex>Solution2.input() |> Solution2.show()
  9 6 2015
  6 6 2015
  45
  :ok

  iex>Solution2.input() |> Solution2.show()
  9 7 2015
  6 6 2015
  500
  :ok

  iex>Solution2.input() |> Solution2.show()
  9 6 2016
  6 6 2015
  10000
  :ok
  """

  def process([[day_returned, month_returned, year_returned], [day_due, month_due, year_due]])
      when day_returned <= day_due and month_returned <= month_due and year_returned <= year_due do
    0
  end

  def process([[_day_returned, month_returned, year_returned], [_day_due, month_due, year_due]])
      when month_returned < month_due and year_returned == year_due do
    0
  end

  def process([[_day_returned, _month_returned, year_returned], [_day_due, _month_due, year_due]])
      when year_returned < year_due do
    0
  end

  def process([[day_returned, month_returned, year_returned], [day_due, month_due, year_due]])
      when month_returned == month_due and year_returned == year_due do
    (day_returned - day_due) * 15
  end

  def process([[_day_returned, month_returned, year_returned], [_day_due, month_due, year_due]])
      when year_returned == year_due do
    (month_returned - month_due) * 500
  end

  def process(_) do
    10000
  end

  def show(input) do
    IO.puts(process(input))
  end

  def input do
    1..2
    |> Enum.map(fn _ ->
      IO.read(:stdio, :line)
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(&(&1 |> String.to_integer()))
    end)
  end
end
