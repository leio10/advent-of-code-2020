defmodule AdventOfCode.Day5.Part2 do
  def run(input) do
    ids = input
          |> Enum.map(&String.trim/1)
          |> Enum.map(&get_id/1)
          |> MapSet.new()

    min = Enum.min(ids)
    max = Enum.max(ids)

    min..max
    |> MapSet.new()
    |> MapSet.difference(ids)
    |> Enum.join("")
    |> IO.puts()
  end

  defp get_id(line) do
    get_id(line, {0, 127}, {0, 7})
  end

  defp get_id("F" <> line, row, col) do get_id(line, first_half(row), col) end
  defp get_id("B" <> line, row, col) do get_id(line, last_half(row), col)  end
  defp get_id("L" <> line, row, col) do get_id(line, row, first_half(col)) end
  defp get_id("R" <> line, row, col) do get_id(line, row, last_half(col))  end

  defp get_id("", {row, _}, {col, _}) do
    row * 8 + col
  end

  defp first_half({a, b}) do
    {a, a + div(b-a+1, 2)-1}
  end

  defp last_half({a, b}) do
    {a + div(b-a+1, 2), b}
  end
end
