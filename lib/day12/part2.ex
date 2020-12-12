defmodule AdventOfCode.Day12.Part2 do
  def run(input) do
    input
    |> Enum.map(&String.trim/1)
    |> move({0, 0}, {10, -1})
    |> Tuple.to_list()
    |> Enum.map(&abs/1)
    |> Enum.sum()
    |> IO.puts()
  end

  defp move([], pos, _) do pos end
  defp move(["W" <> distance | tail], pos, {x, y}) do
    move(tail, pos, {x - String.to_integer(distance), y})
  end
  defp move(["E" <> distance | tail], pos, {x, y}) do
    move(tail, pos, {x + String.to_integer(distance), y})
  end
  defp move(["N" <> distance | tail], pos, {x, y}) do
    move(tail, pos, {x, y - String.to_integer(distance)})
  end
  defp move(["S" <> distance | tail], pos, {x, y}) do
    move(tail, pos, {x, y + String.to_integer(distance)})
  end
  defp move(["F" <> distance | tail], {x, y}, {dx, dy} = way) do
    move(tail, {x + dx * String.to_integer(distance), y + dy * String.to_integer(distance)}, way)
  end
  defp move(["R" <> degrees | tail], pos, way) do
    move(
      tail,
      pos,
      degrees
      |> String.to_integer()
      |> div(90)
      |> rotate(way)
    )
  end
  defp move(["L" <> degrees | tail], pos, way) do
    move(
      tail,
      pos,
      degrees
      |> String.to_integer()
      |> div(-90)
      |> rotate(way)
    )
  end

  defp rotate(0, way) do way end
  defp rotate(steps, {x, y}) do
    rotate(
      steps - sign(steps),
      {
        sign(-1 * sign(steps) * sign(y)) * abs(y),
        sign(     sign(steps) * sign(x)) * abs(x)
      }
    )
  end

  defp sign(val) when val < 0 do -1 end
  defp sign(_) do 1 end
end
