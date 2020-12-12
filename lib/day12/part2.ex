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
      to_zero(steps),
      {
        sign(true, steps>=0, x>=0, y>=0) * abs(y),
        sign(false, steps>=0, x>=0, y>=0) * abs(x)
      }
    )
  end

  defp to_zero(var) when var < 0 do var + 1 end
  defp to_zero(var) do var - 1 end

  # [++ > -+ > -- > +-] cycle rotation based on axis and direction
  # defp sign(x?, r?, x+?, y+?)
  defp sign(true, true, _, true) do -1 end    # x r _+ -> -
  defp sign(true, true, _, false) do 1 end    # x r _- -> +
  defp sign(true, false, _, true) do 1 end    # x l _+ -> +
  defp sign(true, false, _, false) do -1 end  # x l _- -> -

  defp sign(false, true, true, _) do 1 end     # y r +_ -> +
  defp sign(false, true, false, _) do -1 end   # y r -_ -> -
  defp sign(false, false, true, _) do -1 end   # y l +_ -> -
  defp sign(false, false, false, _) do 1 end   # y l -_ -> +
end
