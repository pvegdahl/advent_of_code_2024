defmodule AdventOfCode2024.Day07 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    lines
    |> parse_input()
    |> Enum.filter(fn {target, numbers} -> can_do?(target, numbers, [:+, :*]) end)
    |> Enum.map(fn {target, _numbers} -> target end)
    |> Enum.sum()
  end

  def parse_input(lines) do
    Enum.map(lines, fn line ->
      [target_as_string, numbers_as_string] = String.split(line, ":")

      target = String.to_integer(target_as_string)

      numbers =
        numbers_as_string
        |> String.trim()
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)

      {target, numbers}
    end)
  end

  def can_do?(target, [head | tail], operators), do: can_do_recursion?(target, [head], tail, operators)

  defp can_do_recursion?(target, possibilities, [], _operators), do: MapSet.member?(possibilities, target)

  defp can_do_recursion?(target, possibilities, [head | tail], operators) do
    new_possibilities =
      for possibility <- possibilities, operator <- operators, into: MapSet.new() do
        apply_operator(possibility, head, operator)
      end

    can_do_recursion?(target, new_possibilities, tail, operators)
  end

  defp apply_operator(a, b, :+), do: a + b
  defp apply_operator(a, b, :*), do: a * b

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day07.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day07.txt")
    |> part_b()
  end
end
