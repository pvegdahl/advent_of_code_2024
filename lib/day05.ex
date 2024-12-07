defmodule AdventOfCode2024.Day05 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    {rules, page_order_lines} = parse_lines(lines)

    page_order_lines
    |> Enum.filter(&valid_ordering?(&1, rules))
    |> Enum.map(&middle_number/1)
    |> Enum.sum()
  end

  defp parse_lines(lines) do
    {rule_lines, ["" | page_order_lines]} = Enum.split_while(lines, fn line -> line != "" end)

    {parse_rules(rule_lines),
     Enum.map(page_order_lines, fn line -> line |> String.split(",") |> Enum.map(&String.to_integer/1) end)}
  end

  def parse_rules(rule_lines) do
    rule_lines =
      rule_lines
      |> Enum.map(fn rule_line -> rule_line |> String.split("|") |> Enum.map(&String.to_integer/1) end)
      |> Enum.group_by(&List.first/1, &List.last/1)
      |> Map.new(fn {key, value} -> {key, MapSet.new(value)} end)

    empty_pairs_for_all_values =
      rule_lines
      |> flatten_values()
      |> Map.new(&{&1, MapSet.new()})

    Map.merge(empty_pairs_for_all_values, rule_lines)
  end

  defp flatten_values(map) do
    map
    |> Map.values()
    |> Enum.concat()
    |> Enum.uniq()
  end

  def valid_ordering?(page_order, rules) do
    page_order
    |> Enum.reverse()
    |> valid_reversed_ordering?(rules)
  end

  defp valid_reversed_ordering?([_], _rules), do: true

  defp valid_reversed_ordering?([head | tail], rules) do
    problem_numbers = Map.get(rules, head, MapSet.new())

    if Enum.any?(tail, &MapSet.member?(problem_numbers, &1)) do
      false
    else
      valid_reversed_ordering?(tail, rules)
    end
  end

  def middle_number(page_order) do
    index = div(Enum.count(page_order), 2)
    Enum.at(page_order, index)
  end

  def part_b(lines) do
    {rules, page_order_lines} = parse_lines(lines)
    full_ordering = rules_to_order(rules)

    page_order_lines
    |> Enum.reject(&valid_ordering?(&1, rules))
    |> Enum.map(&valid_order(&1, full_ordering))
    |> Enum.map(&middle_number/1)
    |> Enum.sum()
  end

  def rules_to_order(rules) when map_size(rules) == 0, do: []

  def rules_to_order(rules) do
    keys =
      rules
      |> Map.keys()
      |> MapSet.new()

    values =
      rules
      |> flatten_values()
      |> MapSet.new()

    keys_not_in_values = MapSet.difference(keys, values) |> Enum.to_list()
    pruned_rules = Map.drop(rules, keys_not_in_values)

    keys_not_in_values ++ rules_to_order(pruned_rules)
  end

  defp valid_order(order, full_ordering) do
    Enum.filter(full_ordering, &Enum.member?(order, &1))
  end

  def a() do
    Helpers.file_to_lines!("inputs/day05.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day05.txt")
    |> part_b()
  end
end
