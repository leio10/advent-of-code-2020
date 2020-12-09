defmodule AdventOfCode.Day9.Part1 do
  def run(input) do
    input
    |> Enum.map(&String.trim/1)
    |> find_invalid([], 25)
    |> IO.puts()
  end

  defp find_invalid([head | tail], acum, missing) when missing > 0 do
    find_invalid(tail, push(acum, String.to_integer(head)), missing - 1)
  end

  defp find_invalid([head | tail], [_ | rest] = acum, _) do
    number = String.to_integer(head)
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
end
