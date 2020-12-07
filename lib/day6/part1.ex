defmodule AdventOfCode.Day6.Part1 do
  def run(input) do
    input
    |> Stream.concat([""])
    |> Enum.map(&String.trim/1)
    |> Enum.reduce({MapSet.new(), 0}, &process/2)
    |> elem(1)
    |> IO.puts()
  end

  defp process("", { current, count }) do
    {MapSet.new(), count + MapSet.size(current) - 1}
  end

  defp process(line, { current, count }) do
    {
      line
      |> String.split("")
      |> Enum.concat(current)
      |> MapSet.new(),
      count
    }
  end
end
