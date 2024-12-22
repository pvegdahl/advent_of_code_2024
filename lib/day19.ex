defmodule AdventOfCode2024.Day19 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    {towels, targets} = parse_input(lines)

    max_towel_index = towels |> Enum.map(&String.length/1) |> Enum.max() |> then(&(&1 - 1))

    targets
    |> Enum.filter(fn target -> possible?(target, MapSet.new(towels), max_towel_index) end)
    |> Enum.count()
  end

  def parse_input([towel_line, "" | rest]) do
    towels =
      towel_line
      |> String.split(",")
      |> Enum.map(&String.trim/1)

    {towels, rest}
  end

  def possible?("", _towels, _max_towel_size), do: true

  def possible?(target, towels, max_towel_index) do
    towels
    |> possible_towels(target, max_towel_index)
    |> Enum.any?(fn towel ->
      String.starts_with?(target, towel) and possible?(String.trim_leading(target, towel), towels, max_towel_index)
    end)
  end

  defp possible_towels(towels, target, max_towel_index) do
    0..max_towel_index
    |> Enum.map(fn n -> String.slice(target, 0..n) end)
    |> MapSet.new()
    |> MapSet.intersection(towels)
  end

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day19.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day19.txt")
    |> part_b()
  end
end
