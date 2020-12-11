defmodule AdventOfCode.Day11.Part2 do
  def run(input) do
    input
    |> Enum.map(&String.trim/1)
    |> parse_layout(0)
    |> seats_with_limits()
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

  defp seats_with_limits(seats) do
    {
      seats
      |> MapSet.new(),
      {
        seats
        |> Enum.map(&(elem(&1, 0)))
        |> Enum.max(),
        seats
        |> Enum.map(&(elem(&1, 1)))
        |> Enum.max()
      }
    }
  end

  defp iterate_occupation({seats, _} = seats_and_limits, occupation) do
    seats
    |> Enum.filter(&(occupied?(&1, seats_and_limits, occupation)))
    |> MapSet.new()
    |> equal_or_iterate(seats_and_limits, occupation)
  end

  defp equal_or_iterate(new_occupation, seats_and_limits, occupation) do
    new_occupation
    |> MapSet.equal?(occupation)
    && new_occupation
    || iterate_occupation(seats_and_limits, new_occupation)
  end

  defp occupied?(seat, seats_and_limits, occupation) do
    occupation
    |> MapSet.member?(seat) && occupied_adjacents(seat, seats_and_limits, occupation) < 5
    || occupied_adjacents(seat, seats_and_limits, occupation) == 0
  end

  defp occupied_adjacents(seat, seats_and_limits, occupation) do
    seat
    |> adjacents(seats_and_limits)
    |> MapSet.intersection(occupation)
    |> Enum.count()
  end

  defp adjacents(seat, seats_and_limits) do
    [{-1, -1}, {0, -1}, {1, -1},
     {-1, 0},           {1, 0},
     {-1, 1},  {0, 1},  {1, 1}]
    |> Enum.map(&(search_adjacent(seat, seats_and_limits, &1)))
    |> MapSet.new()
  end

  defp search_adjacent(seat, seats_and_limits, direction) do
    seat
    |> adjacent(direction)
    |> seat_or_keep_searching(seats_and_limits, direction)
  end

  defp seat_or_keep_searching(seat, { seats, limits } = seats_and_limits, direction) do
    seats
    |> MapSet.member?(seat) && seat
    || out_of_bounds?(seat, limits) && seat
    || search_adjacent(seat, seats_and_limits, direction)
  end

  defp adjacent({col, row}, {dcol, drow}) do
    {col+dcol, row+drow}
  end

  defp out_of_bounds?({col, row}, {cols, rows}) do
    col < 0
    || col > cols
    || row < 0
    || row > rows
  end
end
