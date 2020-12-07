defmodule AdventOfCode.Day2.Part1 do
  def run(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.map(&is_valid?/1)
    |> Enum.count(&Function.identity/1)
    |> IO.puts
  end

  defp parse_line(line) do
    [[_, min, max, key, password]] = Regex.scan(~r"(\d+)\-(\d+) (.)\: (.+)", line)
    {:ok, regex_key} = Regex.compile(key)
    {%{ range: %Range{first: elem(Integer.parse(min),0), last: elem(Integer.parse(max),0)}, key: regex_key}, password}
  end

  defp is_valid?({%{range: range, key: key}, password}) do
    Regex.scan(key, password)
    |> Enum.count()
    |> (fn(x) -> x in range end).()
  end
end
