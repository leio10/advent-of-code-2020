defmodule AdventOfCode.Day3.Part2 do
  def run(input) do
    input
    |> Enum.to_list()
    |> Enum.map(&String.trim/1)
    |> multiply_results()
    |> IO.puts()
  end

  defp multiply_results(input) do
    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(fn(slope) -> calculate_results(input, slope) end)
    |> Enum.reduce(fn(x, acc) -> x * acc end)
  end

  defp calculate_results(input, {x, y}) do
    input
    |> count_trees({x, y}, {0, 0})
  end

  defp count_trees([], _, _) do
    0
  end

  defp count_trees([head | tail], {x, y}, {left, top}) when rem(top, y) == 0 do
    count_tree(read(head, left)) + count_trees(tail, {x, y}, {left + x, top + 1})
  end

  defp count_trees([_ | tail], slope, {left, top}) do
    count_trees(tail, slope, {left, top + 1})
  end

  defp read(line, left) do
    line
    |> String.at(rem(left, String.length(line)))
  end

  defp count_tree("#") do 1 end
  defp count_tree(".") do 0 end
  defp count_tree(_) do raise "oops" end
end
