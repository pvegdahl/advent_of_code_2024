defmodule AdventOfCode2024.Day23 do
  alias AdventOfCode2024.Helpers
  alias AdventOfCode2024.Cache

  def part_a(lines) do
    mapping = parse_input(lines)

    starts_with_t = keys_starting_with(mapping, "t")

    starts_with_t
    |> Enum.flat_map(fn key -> find_triples_for(key, mapping) end)
    |> Enum.uniq()
    |> Enum.count()
  end

  def parse_input(lines) do
    lines
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.flat_map(fn [a, b] -> [{a, b}, {b, a}] end)
    |> Enum.group_by(fn {key, _value} -> key end, fn {_key, value} -> value end)
    |> Map.new(fn {key, values} -> {key, MapSet.new(values)} end)
  end

  defp keys_starting_with(mapping, starting_pattern) do
    mapping
    |> Map.keys()
    |> Enum.filter(fn key -> String.starts_with?(key, starting_pattern) end)
  end

  def find_triples_for(target, mapping) do
    target_connections = Map.get(mapping, target)

    target_connections
    |> Enum.flat_map(fn connection ->
      mapping
      |> Map.get(connection)
      |> MapSet.intersection(target_connections)
      |> Enum.map(fn mutual_connection ->
        [target, connection, mutual_connection]
        |> Enum.sort()
        |> List.to_tuple()
      end)
    end)
    |> Enum.uniq()
  end

  def part_b(lines) do
    mappings = parse_input_b(lines)

    {:ok, cache} = Cache.init()

    mappings
    |> starting_states()
    |> Enum.map(fn {node, map} -> maximal_clique(node, map, cache) end)
    |> Enum.max_by(&Enum.count/1)
    |> Enum.sort()
    |> Enum.join(",")
  end

  # Plan:
  # For each key, get their list of connection+self to start. Track two things:
  #   1) IDs added (grows over time)
  #   2) Intersection of all connections+self (shrinks over time)
  # Keep adding new IDs from the intersection. Terminates when either:
  #   1) IDs == intersection
  #   2) The IDs are not a subset of the intersections <-- I don't think this can happen
  # Do this iterative search for one starting starting ID to find the biggest collection, then do it again
  # with the next ID, but you can prune the first ID from the map.

  defp parse_input_b(lines) do
    lines
    |> parse_input()
    |> Map.new(fn {key, values} -> {key, MapSet.put(values, key)} end)
  end

  defp starting_states(mappings) do
    Stream.iterate(start_tuple(mappings), fn {key, remaining_mappings} ->
      remaining_mappings
      |> prune_mappings(key)
      |> start_tuple()
    end)
    |> Stream.take_while(fn {_key, remaining_mappings} -> map_size(remaining_mappings) > 3 end)
  end

  defp start_tuple(mappings) do
    {a_key, _value} = Enum.at(mappings, 0)
    {a_key, mappings}
  end

  defp maximal_clique(starting_id, mappings, cache) do
    maximal_clique(MapSet.new([starting_id]), Map.get(mappings, starting_id), mappings, cache)
  end

  defp maximal_clique(ids, intersection, mappings, cache) do
    cond do
      Cache.has_key?(cache, ids) ->
        Cache.get(cache, ids)

      ids == intersection ->
        ids

      true ->
        candidate_ids = MapSet.difference(intersection, ids)

        result =
          candidate_ids
          |> Enum.map(fn id ->
            new_ids = MapSet.put(ids, id)
            new_intersection = Map.get(mappings, id) |> MapSet.intersection(intersection)
            maximal_clique(new_ids, new_intersection, mappings, cache)
          end)
          |> Enum.max_by(&Enum.count/1)

        Cache.put(cache, ids, result)
        result
    end
  end

  defp prune_mappings(mappings, key_to_prune) do
    mappings
    |> Map.delete(key_to_prune)
    |> Map.new(fn {key, values} -> {key, MapSet.delete(values, key_to_prune)} end)
  end

  def a() do
    Helpers.file_to_lines!("inputs/day23.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day23.txt")
    |> part_b()
  end
end
