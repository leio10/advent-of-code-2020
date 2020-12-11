defmodule AdventOfCode.Day11.Part1 do
  def run(input) do
    input
    |> Enum.map(&String.trim/1)
    |> parse_layout(0)
    |> MapSet.new()
    |> iterate_occupation(MapSet.new())
    |> Enum.count()
    |> IO.puts()
  end

  defp parse_layout([], _) do [] end
  defp parse_layout([head | tail], row) do
    head
    |> parse_row(0, row)
    |> Enum.concat(parse_layout(tail, row + 1))
  end

  defp parse_row("", _, _) do [] end
  defp parse_row("." <> rest, col, pos) do parse_row(rest, col + 1, pos) end
  defp parse_row("L" <> rest, col, pos) do
    [{col, pos}]
    |> Enum.concat(parse_row(rest, col + 1, pos))
  end

  defp iterate_occupation(seats, occupation) do
    seats
    |> Enum.filter(&(occupied?(&1, occupation)))
    |> MapSet.new()
    |> equal_or_iterate(occupation, seats)
  end

  defp equal_or_iterate(new_occupation, occupation, seats) do
    new_occupation
    |> MapSet.equal?(occupation)
    && new_occupation
    || iterate_occupation(seats, new_occupation)
  end

  defp occupied?(seat, occupation) do
    occupation
    |> MapSet.member?(seat)
    && occupied_adjacents(seat, occupation) < 4
    || occupied_adjacents(seat, occupation) == 0
  end

  defp occupied_adjacents(seat, occupation) do
    seat
    |> adjacents()
    |> MapSet.intersection(occupation)
    |> Enum.count()
  end

  defp adjacents({col, row}) do
    MapSet.new([
      {col - 1, row - 1}, {col, row - 1}, {col + 1, row - 1},
      {col - 1, row},                     {col + 1, row},
      {col - 1, row + 1}, {col, row + 1}, {col + 1, row + 1}
    ])
  end
end
