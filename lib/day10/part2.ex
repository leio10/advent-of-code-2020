defmodule AdventOfCode.Day10.Part2 do
  require :math

  def run(input) do
    input
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
    |> differences(0)
    |> solve_it()
    |> IO.puts()
  end

  defp differences([], _) do [] end
  defp differences([head | tail], prev) do
    [ head - prev | differences(tail, head) ]
  end

  defp solve_it(list) do
    splitted_probs({[], list})
  end

  defp splitted_probs({ [], [] }) do 1 end
  defp splitted_probs({ list, [ 3 | rest] }) do splitted_probs({list, rest}) end
  defp splitted_probs({ list, rest }) do
    rest
    |> Enum.split_while(&(&1 != 3))
    |> splitted_probs()
    |> Kernel.*(probs(list))
  end

  defp probs([]) do 1 end
  defp probs([1 | [1 | rest]]) do probs([2 | rest]) + probs([1 | rest]) end
  defp probs([1 | [2 | rest]]) do probs([2 | rest]) + probs(rest) end
  defp probs([2 | [1 | rest]]) do probs([1 | rest]) + probs(rest) end
  defp probs([_ | rest]) do probs(rest) end
end
