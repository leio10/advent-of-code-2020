defmodule AdventOfCode.Day7.Part1 do
  def run(input) do
    input
    |> Enum.map(&String.trim/1)
    |> Enum.map(&process/1)
    |> List.flatten()
    |> search(MapSet.new(["shiny gold bag"]))
    |> MapSet.size()
    |> IO.puts()
  end

  defp process(line) do
    line
    |> String.trim(".")
    |> String.split(~r" contain |, ")
    |> parse_rules()
  end

  defp parse_rules([_ | ["no other bags"]]) do [] end
  defp parse_rules([bag | bags]) do
    bags
    |> Enum.map(&parse_rule/1)
    |> Enum.map(fn({_, to}) -> {String.trim_trailing(bag, "s"), to} end)
  end

  defp parse_rule(rule) do
    rule
    |> String.split(" ", parts: 2)
    |> Enum.map(fn(bag) -> String.trim_trailing(bag, "s") end)
    |> List.to_tuple()
  end

  defp search(rules, bags) do
    rules
    |> search_bags(bags)
    |> search_more(rules)
  end

  defp search_more(bags, rules) do
    more_bags = search_bags(rules, bags)

    if Enum.any?(MapSet.difference(more_bags, bags)) do
      bags
      |> MapSet.union(more_bags)
      |> search_more(rules)
    else
      bags
    end
  end

  defp search_bags(rules, bags) do
    bags
    |> Enum.map(fn(bag) -> search_bag(rules, bag) end)
    |> Enum.concat()
    |> MapSet.new()
  end

  defp search_bag(rules, bag) do
    rules
    |> Enum.map(fn({from, to}) -> if to == bag do from end end)
    |> Enum.filter(& &1)
    |> MapSet.new()
  end
end
