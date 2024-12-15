defmodule AdventOfCode2024.Day14 do
  alias AdventOfCode2024.Helpers

  def part_a(lines, dimensions) do
    final_states =
      lines
      |> parse_input()
      |> move(dimensions, 100)
      |> Enum.map(& &1.location)

    dimensions
    |> quadrants()
    |> Enum.map(fn quadrant -> points_in_ranges(final_states, quadrant) end)
    |> Enum.map(&Enum.count/1)
    |> Enum.product()
  end

  def parse_input(lines) do
    Enum.map(lines, fn line ->
      [x, y, vx, vy] =
        Regex.run(~r/p=(\d+),(\d+) v=([\d-]+),([\d-]+)/, line)
        |> Enum.drop(1)
        |> Enum.map(&String.to_integer/1)

      %{location: {x, y}, velocity: {vx, vy}}
    end)
  end

  def move(location_velocity_pairs, {x_dim, y_dim}, n) do
    Enum.map(location_velocity_pairs, fn %{location: {x, y}, velocity: {vx, vy}} = pair ->
      new_location = {Integer.mod(x + n * vx, x_dim), Integer.mod(y + n * vy, y_dim)}
      %{pair | location: new_location}
    end)
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day14.txt")
    |> part_a({101, 103})
  end

  defp points_in_ranges(points, {x_range, y_range}) do
    Enum.filter(points, fn {x, y} -> x in x_range and y in y_range end)
  end

  def quadrants({x_dim, y_dim}) do
    x_mid = div(x_dim, 2)
    y_mid = div(y_dim, 2)

    x0 = 0..(x_mid - 1)
    x1 = (x_mid + 1)..(x_dim - 1)

    y0 = 0..(y_mid - 1)
    y1 = (y_mid + 1)..(y_dim - 1)

    [{x0, y0}, {x1, y0}, {x0, y1}, {x1, y1}]
  end

  def b() do
    Helpers.file_to_lines!("inputs/day14.txt")
    |> part_b()
  end
end
