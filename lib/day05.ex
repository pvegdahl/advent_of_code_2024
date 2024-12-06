defmodule AdventOfCode2024.Day05 do
  alias AdventOfCode2024.Helpers

  def part_a(_lines) do
  end

  def parse_rules(rule_lines) do
    rule_lines
    |> Enum.map(fn rule_line -> rule_line |> String.split("|") |> Enum.map(&String.to_integer/1) end)
    |> Enum.group_by(&List.first/1, &List.last/1)
    |> Map.new(fn {key, value} -> {key, MapSet.new(value)} end)
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

  def part_b(_lines) do
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
