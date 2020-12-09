defmodule AdventOfCode.Day9.Part2 do
  def run(input) do
    input
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> solve_it()
    |> IO.puts()
  end

  defp solve_it(input) do
    input
    |> find_invalid([], 25)
    |> find_range(input)
    |> sum_min_max(input)
  end

  defp find_range(number, [head | tail]) do
    number
    |> expand_range(head, head, head, tail)
    || find_range(number, tail)
  end

  defp expand_range(number, first, _, _, _) when number == first do nil end
  defp expand_range(number, _, _, acum, _) when acum > number do nil end
  defp expand_range(number, first, last, acum, _) when acum == number do {first, last} end
  defp expand_range(number, first, _, acum, [ head | tail ]) do expand_range(number, first, head, acum + head, tail) end

  defp find_invalid([number | tail], acum, missing) when missing > 0 do
    find_invalid(tail, push(acum, number), missing - 1)
  end

  defp find_invalid([number | tail], [_ | rest] = acum, _) do
    acum
    |> Enum.map(&(number-&1))
    |> Enum.any?(&(&1 in acum))
    && find_invalid(tail, push(rest, number), 0)
    || number
  end

  defp push(list, number) do
    list
    |> Enum.concat([number])
  end

  defp sum_min_max({first, last}, input) do
    input
    |> start_range(first)
    |> end_range([], last)
    |> Enum.sort()
    |> sum_first_last()
  end

  defp start_range([head | tail], first) when head == first do [head | tail] end
  defp start_range([_ | tail], first) do start_range(tail, first) end

  defp end_range([head | _], acum, last) when head == last do [head | acum] end
  defp end_range([head | tail], acum, last) do end_range(tail, [head | acum], last) end

  defp sum_first_last(list) do
    List.first(list) + List.last(list)
  end
end
