defmodule AdventOfCode2024.Day01 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    lines
    |> extract_lists()
    |> Enum.map(&Enum.sort/1)
    |> Enum.zip()
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  defp extract_lists(lines) do
    lines
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [a, b] -> [String.to_integer(a), String.to_integer(b)] end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def part_b(lines) do
    [list1, list2] = extract_lists(lines)

    list2_frequencies = Enum.frequencies(list2)

    list1
    |> Enum.map(fn num -> num * Map.get(list2_frequencies, num, 0) end)
    |> Enum.sum()
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
