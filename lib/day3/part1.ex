defmodule AdventOfCode.Day3.Part1 do
  def run(input) do
    input
    |> Enum.to_list()
    |> count_trees(0)
    |> IO.puts()
  end

  defp count_trees([], _) do
    0
  end

  defp count_trees([ head | tail], position) do
    cond do
      String.at(head, rem(position, String.length(head)-1)) == "#" -> 1
      true -> 0
    end + count_trees(tail, position + 3)
  end
end
