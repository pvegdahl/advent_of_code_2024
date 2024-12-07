defmodule AdventOfCode2024.Day06 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    {start, boxes, dimensions} = parse_input(lines)

    walk([start], boxes, dimensions)
    |> Enum.map(fn {x, y, _direction} -> {x, y} end)
    |> Enum.uniq()
    |> Enum.count()
  end

  def parse_input(lines) do
    boxes =
      lines
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, y_index} -> boxes_in_line(line, y_index) end)
      |> MapSet.new()

    {start_location(lines), boxes, dimensions(lines)}
  end

  defp boxes_in_line(line, y_index) do
    ~r/#/
    |> Regex.scan(line, return: :index)
    |> Enum.map(fn [{x_index, _}] -> {x_index, y_index} end)
  end

  defp start_location(lines) do
    y_index = Enum.find_index(lines, &String.contains?(&1, "^"))

    line = Enum.at(lines, y_index)

    [[{x_index, _}]] = Regex.scan(~r/\^/, line, return: :index)

    {x_index, y_index, :north}
  end

  defp dimensions(lines) do
    y = Enum.count(lines)
    x = lines |> List.first() |> String.length()
    {x, y}
  end

  defp walk([head | _] = points, boxes, dimensions) do
    next = next_step(head, boxes)

    if in_bounds?(next, dimensions) do
      walk([next | points], boxes, dimensions)
    else
      points
    end
  end

  defp next_step({x, y, direction} = point, boxes) do
    candidate_point = next_candidate(point)

    if MapSet.member?(boxes, candidate_point) do
      {x, y, rotate(direction)}
    else
      Tuple.append(candidate_point, direction)
    end
  end

  defp next_candidate({x, y, :north}), do: {x, y - 1}
  defp next_candidate({x, y, :east}), do: {x + 1, y}
  defp next_candidate({x, y, :south}), do: {x, y + 1}
  defp next_candidate({x, y, :west}), do: {x - 1, y}

  defp rotate(:north), do: :east
  defp rotate(:east), do: :south
  defp rotate(:south), do: :west
  defp rotate(:west), do: :north

  defp in_bounds?({x, y, _direction}, {x_dim, y_dim}), do: x >= 0 and x < x_dim and y >= 0 and y < y_dim

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day06.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day06.txt")
    |> part_b()
  end
end
