defmodule AdventOfCode.Day6.Part2 do
  def run(input) do
    input
    |> Stream.concat([""])
    |> Enum.map(&String.trim/1)
    |> Enum.reduce({nil, 0}, &process/2)
    |> elem(1)
    |> IO.puts()
  end

  defp process("", { current, count }) do
    {nil, count + MapSet.size(current) - 1}
  end

  defp process(line, { nil, count }) do
    {to_set(line), count}
  end

  defp process(line, { current, count }) do
    {line |> to_set |> MapSet.intersection(current), count}
  end

  defp to_set(line) do
    line
    |> String.split("")
    |> MapSet.new()
  end
end
