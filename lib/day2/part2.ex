defmodule AdventOfCode.Day2.Part2 do
  def run(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.filter(&is_valid?/1)
    |> Enum.count()
    |> IO.puts
  end

  defp parse_line(line) do
    [[_, first, last, key, password]] = Regex.scan(~r"(\d+)\-(\d+) (.)\: (.+)", line)
    { elem(Integer.parse(first),0), elem(Integer.parse(last),0), key, password }
  end

  defp is_valid?({first, last, key, password}) do
    (String.at(password, first-1) == key) != (String.at(password, last-1) == key)
  end
end
