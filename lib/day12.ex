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

  def part_b(_lines) do
  end

  def count_sides(_points) do
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
