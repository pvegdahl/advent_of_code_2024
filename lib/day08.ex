defmodule AdventOfCode2024.Day08 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    do_it_all(lines, &pair_to_antinodes_a/1)
  end

  defp do_it_all(lines, pair_to_antinodes_func) do
    dimensions = Helpers.grid_dimensions(lines)

    lines
    |> Helpers.parse_string_grid()
    |> Enum.map(fn {_char, antennas} -> antinodes(antennas, dimensions, pair_to_antinodes_func) end)
    |> Enum.reduce(&MapSet.union/2)
    |> MapSet.size()
  end

  def antinodes(antennas, dimensions, pair_to_antinodes_func) do
    antennas
    |> pairs()
    |> Enum.flat_map(pair_to_antinodes_func)
    |> Enum.filter(fn point -> Helpers.in_bounds?(point, dimensions) end)
    |> MapSet.new()
  end

  defp pairs(antennas) do
    for a <- antennas, b <- antennas, a != b, uniq: true do
      [a, b]
      |> Enum.sort()
      |> List.to_tuple()
    end
  end

  def pair_to_antinodes_a({{x0, y0}, {x1, y1}}) do
    x_diff = x1 - x0
    y_diff = y1 - y0
    [{x0 - x_diff, y0 - y_diff}, {x1 + x_diff, y1 + y_diff}]
  end

  def part_b(lines) do
    do_it_all(lines, &pair_to_antinodes_b/1)
  end

  def pair_to_antinodes_b({{x0, y0}, {x1, y1}}) do
    x_diff = x1 - x0
    y_diff = y1 - y0
    [{x0 - x_diff, y0 - y_diff}, {x1 + x_diff, y1 + y_diff}]
  end

  def a() do
    Helpers.file_to_lines!("inputs/day08.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day08.txt")
    |> part_b()
  end
end
