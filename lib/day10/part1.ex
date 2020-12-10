defmodule AdventOfCode.Day10.Part1 do
  def run(input) do
    input
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
    |> process_jolts(0, 0, 1)
    |> IO.puts()
  end

  defp process_jolts([], _, ones, threes) do ones * threes end
  defp process_jolts([head | tail], prev, ones, threes) when head == prev + 1 do
    process_jolts(tail, head, ones + 1, threes)
  end
  defp process_jolts([head | tail], prev, ones, threes) when head == prev + 3 do
    process_jolts(tail, head, ones, threes + 1)
  end
end
