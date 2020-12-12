defmodule AdventOfCode.Day12.Part1 do
  def run(input) do
    input
    |> Enum.map(&String.trim/1)
    |> move({0, 0}, [{1, 0}, {0, 1}, {-1, 0}, {0, -1}])
    |> Tuple.to_list()
    |> Enum.map(&abs/1)
    |> Enum.sum()
    |> IO.puts()
  end

  defp move([], pos, _) do pos end
  defp move(["W" <> distance | tail], {x, y}, dir) do
    move(tail, {x - String.to_integer(distance), y}, dir)
  end
  defp move(["E" <> distance | tail], {x, y}, dir) do
    move(tail, {x + String.to_integer(distance), y}, dir)
  end
  defp move(["N" <> distance | tail], {x, y}, dir) do
    move(tail, {x, y - String.to_integer(distance)}, dir)
  end
  defp move(["S" <> distance | tail], {x, y}, dir) do
    move(tail, {x, y + String.to_integer(distance)}, dir)
  end
  defp move(["F" <> distance | tail], {x, y}, [{dx, dy} | _] = dir) do
    move(tail, {x + dx * String.to_integer(distance), y + dy * String.to_integer(distance)}, dir)
  end
  defp move(["R" <> degrees | tail], pos, dir) do
    move(
      tail,
      pos,
      degrees
      |> String.to_integer()
      |> div(90)
      |> rotate(dir)
    )
  end
  defp move(["L" <> degrees | tail], pos, dir) do
    move(
      tail,
      pos,
      degrees
      |> String.to_integer()
      |> div(-90)
      |> rotate(dir)
    )
  end

  defp rotate(0, list) do list end
  defp rotate(steps, list) when steps < 0 do
    rotate(steps + 1, Enum.concat(Enum.slice(list, 3, 1), Enum.slice(list, 0, 3)))
  end

  defp rotate(steps, [head | tail]) when steps > 0 do
    rotate(steps - 1, Enum.concat(tail, [head]))
  end
end
