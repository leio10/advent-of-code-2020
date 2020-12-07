defmodule AdventOfCode.Day7.Part2 do
  def run(input) do
    input
    |> Enum.map(&String.trim/1)
    |> Enum.map(&process/1)
    |> List.flatten()
    |> count({-1, [{"shiny gold bag", 1}]})
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
    |> Enum.map(fn({count, to}) -> {String.trim_trailing(bag, "s"), to, parse_count(count)} end)
  end

  defp parse_rule(rule) do
    rule
    |> String.split(" ", parts: 2)
    |> Enum.map(fn(bag) -> String.trim_trailing(bag, "s") end)
    |> List.to_tuple()
  end

  defp parse_count(value) do
    case Integer.parse(value) do
      { num, _ } -> num
      :error -> raise "oops"
    end
  end

  defp count(rules, bags) do
    rules
    |> count_bags(bags)
    |> count_more(rules)
  end

  defp count_more(acum_bags, rules) do
    {more_acum, more_bags} = count_bags(rules, acum_bags)

    if Enum.any?(more_bags) do
      {more_acum, more_bags}
      |> count_more(rules)
    else
      more_acum
    end
  end

  defp count_bags(rules, {acum, bags}) do
    bags
    |> Enum.map(fn({bag, c}) -> [c, count_bag(rules, bag, c)] end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> List.to_tuple()
    |> join_counts(acum)
  end

  defp count_bag(rules, bag, mult) do
    rules
    |> Enum.map(fn({from, to, c}) -> if from == bag do {to, mult * c} end end)
    |> Enum.filter(& &1)
  end

  def join_counts({counts, bags}, acum) do
    { acum + Enum.sum(counts), Enum.concat(bags) }
  end
end
