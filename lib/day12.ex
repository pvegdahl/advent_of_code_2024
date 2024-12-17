defmodule AdventOfCode2024.Day12 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    lines
    |> Helpers.parse_string_grid()
    |> Enum.flat_map(fn {_letter, points} -> Helpers.point_groupings(points) end)
    |> Enum.map(&score_point_group/1)
    |> Enum.sum()
  end

  def score_point_group(points) do
    area = MapSet.size(points)
    perimeter = 4 * area - 2 * neighboring_pairs(points)

    area * perimeter
  end

  defp neighboring_pairs(points) do
    if MapSet.size(points) < 2 do
      0
    else
      point = Enum.at(points, 0)
      other_points = MapSet.delete(points, point)
      candidate_neighbors = Helpers.candidate_neighbors(point)
      neighbors = MapSet.intersection(candidate_neighbors, other_points)

      MapSet.size(neighbors) + neighboring_pairs(other_points)
    end
  end

  def part_b(lines) do
    lines
    |> Helpers.parse_string_grid()
    |> Enum.flat_map(fn {_letter, points} -> Helpers.point_groupings(points) end)
    |> Enum.map(&score_point_group_b/1)
    |> Enum.sum()
  end

  def score_point_group_b(points) do
    area = MapSet.size(points)
    sides = count_sides(points)

    area * sides
  end

  def count_sides(points) do
    [{1, 0}, {0, 1}, {-1, 0}, {0, -1}]
    |> Enum.map(fn direction -> count_one_side(points, direction) end)
    |> Enum.sum()
  end

  defp count_one_side(points, direction) do
    points
    |> Enum.reject(fn point -> has_neighbor?(point, points, direction) end)
    |> MapSet.new()
    |> Helpers.point_groupings()
    |> Enum.count()
  end

  defp has_neighbor?({x, y} = _point, points, {dx, dy} = _direction) do
    MapSet.member?(points, {x + dx, y + dy})
  end

  def a() do
    Helpers.file_to_lines!("inputs/day12.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day12.txt")
    |> part_b()
  end
end
