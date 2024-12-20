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

    page_order_lines
    |> Enum.reject(&valid_ordering?(&1, rules))
    |> Enum.map(&reorder(&1, rules))
    |> Enum.map(&middle_number/1)
    |> Enum.sum()
  end

  def reorder(order, rules) do
    order
    |> Enum.reverse()
    |> reorder_reversed(rules)
    |> Enum.reverse()
  end

  defp reorder_reversed([x], _rules), do: [x]

  defp reorder_reversed([head | tail], rules) do
    problem_numbers = Map.get(rules, head, MapSet.new())

    index = Enum.find_index(tail, &MapSet.member?(problem_numbers, &1))

    if is_nil(index) do
      [head | reorder_reversed(tail, rules)]
    else
      new_head = Enum.at(tail, index)
      new_tail = List.replace_at(tail, index, head)
      reorder_reversed([new_head | new_tail], rules)
    end
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
