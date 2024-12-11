defmodule AdventOfCode2024.Day10 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    grid = parse_grid(lines)
    dimensions = Helpers.grid_dimensions(lines)

    grid
    |> Map.get(0)
    |> Enum.map(&all_paths(&1, grid, dimensions))
    |> Enum.map(&MapSet.size/1)
    |> Enum.sum()
  end

  def parse_grid(lines) do
    lines
    |> Helpers.parse_string_grid()
    |> Map.new(fn {key, value} -> {String.to_integer(key), value} end)
  end

  defp all_paths(zero_point, grid, dimensions) do
    Enum.reduce(1..9, [zero_point], fn next_value, points -> next_steps(points, next_value, grid, dimensions) end)
  end

  def next_steps(current_locations, next_value, grid, dimensions) do
    candidates =
      current_locations
      |> Enum.flat_map(&neighbors(&1, dimensions))
      |> MapSet.new()

    viable = Map.get(grid, next_value)

    MapSet.intersection(candidates, viable)
  end

  def neighbors({x, y}, dimensions) do
    [
      {x + 1, y},
      {x - 1, y},
      {x, y + 1},
      {x, y - 1}
    ]
    |> Enum.filter(&Helpers.in_bounds?(&1, dimensions))
  end

  def part_b(lines) do
    grid = parse_grid(lines)
    dimensions = Helpers.grid_dimensions(lines)

    grid
    |> Map.get(0)
    |> all_all_paths(grid, dimensions)
    |> Map.values()
    |> Enum.sum()
  end

  defp all_all_paths(start_locations, grid, dimensions) do
    start_locations_with_count = Enum.map(start_locations, &{&1, 1})

    Enum.reduce(1..9, start_locations_with_count, fn next_value, locations_with_counts ->
      next_steps_with_count(locations_with_counts, next_value, grid, dimensions)
    end)
  end

  defp next_steps_with_count(location_counts, next_value, grid, dimensions) do
    location_counts
    |> Enum.map(fn {location, count} -> one_next_steps_with_count(location, count, next_value, grid, dimensions) end)
    |> Enum.reduce(fn map1, map2 -> Map.merge(map1, map2, fn _k, v1, v2 -> v1 + v2 end) end)
  end

  defp one_next_steps_with_count(location, count, next_value, grid, dimensions) do
    candidates = neighbors(location, dimensions) |> MapSet.new()

    viable = Map.get(grid, next_value)

    MapSet.intersection(candidates, viable)
    |> Map.new(&{&1, count})
  end

  def a() do
    Helpers.file_to_lines!("inputs/day10.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day10.txt")
    |> part_b()
  end
end
