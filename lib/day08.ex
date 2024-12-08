defmodule AdventOfCode2024.Day08 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    do_it_all(lines, &pair_to_antinodes_a/2)
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
    |> Enum.flat_map(fn pair -> pair_to_antinodes_func.(pair, dimensions) end)
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

  def pair_to_antinodes_a({{x0, y0}, {x1, y1}}, _dimensions) do
    x_diff = x1 - x0
    y_diff = y1 - y0
    [{x0 - x_diff, y0 - y_diff}, {x1 + x_diff, y1 + y_diff}]
  end

  def part_b(lines) do
    do_it_all(lines, &pair_to_antinodes_b/2)
  end

  def pair_to_antinodes_b({{x0, y0} = point0, {x1, y1}}, dimensions) do
    x_diff = x1 - x0
    y_diff = y1 - y0

    forward_points = points_on_line(point0, {x_diff, y_diff}, dimensions)
    [_point0 | backwards_points] = points_on_line(point0, {-x_diff, -y_diff}, dimensions)

    backwards_points ++ forward_points
  end

  defp points_on_line(starting_point, {x_diff, y_diff}, dimensions) do
    starting_point
    |> Stream.iterate(fn {x, y} -> {x + x_diff, y + y_diff} end)
    |> Enum.take_while(fn point -> Helpers.in_bounds?(point, dimensions) end)
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
