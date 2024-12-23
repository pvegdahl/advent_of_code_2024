defmodule AdventOfCode2024.Day23 do
  alias AdventOfCode2024.Helpers

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

  def part_b(_lines) do
    -1
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
