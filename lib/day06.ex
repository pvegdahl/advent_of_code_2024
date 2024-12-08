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
    %{"^" => start_locations, "#" => boxes} = Helpers.parse_string_grid(lines)

    {x, y} = Enum.at(start_locations, 0)
    {{x, y, :north}, boxes, dimensions(lines)}
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

  def part_b(lines) do
    {start, boxes, dimensions} = parse_input(lines)

    candidate_boxes = candidate_boxes(start, boxes, dimensions)
    num_candidates = MapSet.size(candidate_boxes)
    num_processes = System.schedulers_online()
    chunk_size = ceil(num_candidates / num_processes)

    candidate_boxes
    |> Enum.chunk_every(chunk_size)
    |> Task.async_stream(fn candidates -> count_loops(start, boxes, dimensions, candidates) end, timeout: :infinity)
    |> Enum.map(fn {:ok, num} -> num end)
    |> Enum.sum()
  end

  defp candidate_boxes({start_x, start_y, _direction}, boxes, {x_dim, y_dim}) do
    all_points = for x <- 0..(x_dim - 1), y <- 0..(y_dim - 1), into: MapSet.new(), do: {x, y}

    all_points
    |> MapSet.difference(boxes)
    |> MapSet.delete({start_x, start_y})
  end

  defp count_loops(start, boxes, dimensions, candidate_boxes) do
    starting_points = MapSet.new([start])

    candidate_boxes
    |> Enum.map(&MapSet.put(boxes, &1))
    |> Enum.count(&loop?(start, starting_points, &1, dimensions))
  end

  defp loop?(current, points, boxes, dimensions) do
    next = next_step(current, boxes)

    cond do
      MapSet.member?(points, next) -> true
      in_bounds?(next, dimensions) -> loop?(next, MapSet.put(points, next), boxes, dimensions)
      true -> false
    end
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
