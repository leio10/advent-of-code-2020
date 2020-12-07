defmodule AdventOfCode.Day4.Part2 do
  def run(input) do
    input
    |> Stream.concat([""])
    |> Enum.map(&String.trim/1)
    |> Enum.reduce({[], 0}, &process/2)
    |> elem(1)
    |> IO.puts()
  end

  defp process("", { current, count }) do
    {[], count + valid_passport(current)}
  end

  defp process(line, { current, count }) do
    { [ line | current ], count }
  end

  defp valid_passport(passport) do
    if fields(passport) == 7 do
      1
    else
      0
    end
  end

  defp fields(passport) do
    passport
    |> Enum.join(" ")
    |> String.split(" ")
    |> Enum.map(&valid_field/1)
    |> Enum.count(& &1)
  end

  defp valid_field(field) do
    field
    |> String.split(":")
    |> List.to_tuple()
    |> valid_value()
  end

  defp valid_value({"byr", value}) do year(value) in 1920..2002 end
  defp valid_value({"iyr", value}) do year(value) in 2010..2020 end
  defp valid_value({"eyr", value}) do year(value) in 2020..2030 end
  defp valid_value({"hgt", value}) do
    case Integer.parse(value) do
      { num, "cm" } -> num in 150..193
      { num, "in" } -> num in 59..76
      { _, _ } -> false
      _ -> false
    end
  end
  defp valid_value({"hcl", value}) do Regex.match?(~r"^\#[0-9a-fA-F]{6}$", value) end
  defp valid_value({"ecl", value}) do Enum.member?(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"], value) end
  defp valid_value({"pid", value}) do Regex.match?(~r"^\d{9}$", value) end
  defp valid_value(_) do false end

  defp year(value) do
    case Integer.parse(value) do
      { num, _ } -> num
      :error -> -1
    end
  end
end
