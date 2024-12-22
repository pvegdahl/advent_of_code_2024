defmodule AdventOfCode2024.Day22 do
  alias AdventOfCode2024.Helpers

  def part_a(_lines) do
    -1
  end

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day22.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day22.txt")
    |> part_b()
  end
end
