defmodule AdventOfCode2024.Day15 do
  alias AdventOfCode2024.Helpers

  def part_a(_lines) do
  end

  def parse_input(lines) do
    {grid_lines, instruction_lines} = Enum.split_while(lines, &(String.length(&1) > 0))

    grid =
      grid_lines
      |> Helpers.parse_string_grid()
      |> reverse_grid_map()

    instructions =
      instruction_lines
      |> Enum.join("")
      |> String.graphemes()

    {grid, instructions}
  end

  defp reverse_grid_map(grid_map) do
    grid_map
    |> Enum.flat_map(fn {character, points} -> Enum.map(points, &{&1, character}) end)
    |> Map.new()
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day15.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day15.txt")
    |> part_b()
  end
end
