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

  def part_b(lines) do
    %{start: start, target: target, graph: graph} = input_to_graph(lines)

    # graphlib doesn't seem to work for finding all paths. Not sure why not. I wrote my own search algo :-\
    graph
    |> dijkstra_all_nodes_of_best_paths(start, target)
    |> Enum.count()
  end

  def dijkstra_all_nodes_of_best_paths(graph, start, {target_x, target_y}) do
    to_visit =
      graph
      |> Graph.vertices()
      |> Map.new(fn v -> {v, {:infinity, []}} end)
      |> Map.put(start, {0, []})

    graph_paths = dijkstra_all_recursive(graph, to_visit, %{})

    {horizontal_cost, _parents} = Map.get(graph_paths, {target_x, target_y, :horizontal})
    {vertical_cost, _parents} = Map.get(graph_paths, {target_x, target_y, :vertical})

    cond do
      horizontal_cost == vertical_cost ->
        target_with_parents(graph_paths, {target_x, target_y, :vertical}) ++
          target_with_parents(graph_paths, {target_x, target_y, :horizontal})

      horizontal_cost < vertical_cost ->
        target_with_parents(graph_paths, {target_x, target_y, :horizontal})

      horizontal_cost > vertical_cost ->
        target_with_parents(graph_paths, {target_x, target_y, :vertical})
    end
    |> Enum.map(fn {x, y, _direction} -> {x, y} end)
    |> Enum.uniq()
  end

  defp dijkstra_all_recursive(_graph, to_visit, visited) when map_size(to_visit) == 0, do: visited

  defp dijkstra_all_recursive(graph, to_visit, visited) do
    {v1, {vi_cost, v1_parents}} = to_visit |> Enum.min_by(fn {_vertex, {cost, _parents}} -> cost end)

    to_visit =
      graph
      |> Graph.edges(v1)
      |> Enum.reduce(to_visit, fn %Graph.Edge{v1: va, v2: vb, weight: weight}, acc ->
        [v2] = List.delete([va, vb], v1)

        if Map.has_key?(acc, v2) do
          {cost, v2_parents} = Map.get(acc, v2)
          new_cost = vi_cost + weight

          cond do
            new_cost < cost -> Map.put(acc, v2, {new_cost, [v1]})
            new_cost == cost -> Map.put(acc, v2, {new_cost, [v1 | v2_parents]})
            new_cost > cost -> acc
          end
        else
          acc
        end
      end)
      |> Map.delete(v1)

    visited = Map.put(visited, v1, {vi_cost, v1_parents})

    dijkstra_all_recursive(graph, to_visit, visited)
  end

  defp target_with_parents(visited, target) do
    {_cost, parents} = Map.get(visited, target)
    [target | Enum.flat_map(parents, fn p -> target_with_parents(visited, p) end)]
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
