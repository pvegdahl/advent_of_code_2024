defmodule AdventOfCode2024.Day03 do
  def part_a(text) do
    text
  end

  def parse_numbers(text) do
    [
      Regex.run(~r/mul\((\d+),(\d+)\)/, text)
      |> Enum.drop(1)
      |> Enum.map(&String.to_integer/1)
    ]
  end

  def part_b(_lines) do
  end

  def a() do
    File.read!("inputs/day03.txt")
    |> part_a()
  end

  def b() do
    File.read!("inputs/day03.txt")
    |> part_b()
  end
end
