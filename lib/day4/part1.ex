defmodule AdventOfCode.Day4.Part1 do
  @required_fields MapSet.new(["byr", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"])

  def run(input) do
    input
    |> Stream.concat([""])
    |> Enum.map(&String.trim/1)
    |> Enum.reduce({[], 0}, &process/2)
    |> elem(1)
    |> IO.puts()
  end

  defp process("", { current, count }) do
    {[], count + valid(current)}
  end

  defp process(line, { current, count }) do
    { [ line | current ], count }
  end

  defp valid(passport) do
    if MapSet.subset?(@required_fields, fields(passport)) do
      1
    else
      0
    end
  end

  defp fields(passport) do
    passport
    |> Enum.join(" ")
    |> String.split(" ")
    |> Enum.map(&fieldname/1)
    |> MapSet.new()
  end

  defp fieldname(field) do
    field
    |> String.split(":")
    |> List.first
  end
end
