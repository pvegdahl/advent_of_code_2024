defmodule AdventOfCode2024.Day03 do
  def part_a(text) do
    text
    |> parse_numbers()
    |> Enum.map(fn [a, b] -> a * b end)
    |> Enum.sum()
  end

  def parse_numbers(text) do
    Regex.scan(~r/mul\((\d+),(\d+)\)/, text)
    |> Enum.map(fn [_full_match | num_strings] -> Enum.map(num_strings, &String.to_integer/1) end)
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
