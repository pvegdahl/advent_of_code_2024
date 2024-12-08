defmodule AdventOfCode2024.Day07 do
  alias AdventOfCode2024.Helpers

  def part_a(_lines) do
  end

  def parse_input(lines) do
    Enum.map(lines, fn line ->
      [target_as_string, nums_as_string] = String.split(line, ":")

      target = String.to_integer(target_as_string)

      nums =
        nums_as_string
        |> String.trim()
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)

      {target, nums}
    end)
  end

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
