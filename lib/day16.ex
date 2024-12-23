defmodule AdventOfCode2024.Day16 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    %{start: start, target: {target_x, target_y}, graph: graph} = input_to_graph(lines)

    vertical_path_cost =
      graph
      |> Graph.dijkstra(start, {target_x, target_y, :vertical})
      |> path_cost()

    horizontal_path_cost =
      graph
      |> Graph.dijkstra(start, {target_x, target_y, :horizontal})
      |> path_cost()

      min(horizontal_path_cost, vertical_path_cost)
  end

  def input_to_graph(lines) do
    grid = Helpers.parse_string_grid(lines, ["#"])
    [{start_x, start_y}] = Map.get(grid, "S") |> Enum.to_list()
    [target] = Map.get(grid, "E") |> Enum.to_list()

    graph_points =
      grid
      |> Map.values()
      |> Enum.flat_map(&Enum.to_list/1)
      |> MapSet.new()

    graph =
      Graph.new(type: :undirected)
      |> add_neighbors(graph_points)
      |> add_rotations(graph_points)

    %{start: {start_x, start_y, :horizontal}, target: target, graph: graph}
  end

  defp add_neighbors(graph, graph_points) do
    neighbor_pairs =
      graph_points
      |> Enum.flat_map(&neighbors(&1, graph_points))
      |> Enum.uniq()

    Graph.add_edges(graph, neighbor_pairs)
  end

  defp neighbors(point, graph_points) do
    vertical_neighbors(point, graph_points) ++ horizontal_neighbors(point, graph_points)
  end

  defp vertical_neighbors({x, y} = point, graph_points) do
    [{x, y + 1}, {x, y - 1}]
    |> MapSet.new()
    |> MapSet.intersection(graph_points)
    |> Enum.map(fn neighbor -> Enum.sort([point, neighbor]) end)
    |> Enum.map(fn [{x0, y0}, {x1, y1}] -> {{x0, y0, :vertical}, {x1, y1, :vertical}} end)
  end

  defp horizontal_neighbors({x, y} = point, graph_points) do
    [{x + 1, y}, {x - 1, y}]
    |> MapSet.new()
    |> MapSet.intersection(graph_points)
    |> Enum.map(fn neighbor -> Enum.sort([point, neighbor]) end)
    |> Enum.map(fn [{x0, y0}, {x1, y1}] -> {{x0, y0, :horizontal}, {x1, y1, :horizontal}} end)
  end

  defp add_rotations(graph, graph_points) do
    rotations = Enum.map(graph_points, fn {x, y} -> {{x, y, :vertical}, {x, y, :horizontal}, weight: 1000} end)
    Graph.add_edges(graph, rotations)
  end

  defp path_cost([_]), do: 0
  defp path_cost([{_, _, direction}, {_, _, direction} = b | rest]), do: 1 + path_cost([b | rest])
  defp path_cost([{_, _, _direction_a}, {_, _, _direction_b} = b | rest]), do: 1000 + path_cost([b | rest])

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day16.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day16.txt")
    |> part_b()
  end
end
