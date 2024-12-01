defmodule AdventOfCode2024.Day01 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    lines
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [a, b] -> [String.to_integer(a), String.to_integer(b)] end)
    |> Enum.zip()
    |> Enum.map(&(&1 |> Tuple.to_list() |> Enum.sort()))
    |> Enum.zip()
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day01.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day01.txt")
    |> part_b()
  end
end
