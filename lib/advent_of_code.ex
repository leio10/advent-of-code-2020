defmodule AdventOfCode do
  def input_for(day) do
    File.stream!("lib/day#{day}/input.txt", [:read])
  end

  def day_output(day) do
    input = input_for(day)

    IO.puts("Day #{day}")
    IO.puts("Part 1:")
    apply(String.to_existing_atom("Elixir.AdventOfCode.Day#{day}.Part1"), :run, [input])
    IO.puts("Part 2:")
    apply(String.to_existing_atom("Elixir.AdventOfCode.Day#{day}.Part2"), :run, [input])
  end
end
