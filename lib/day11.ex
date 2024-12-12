defmodule AdventOfCode2024.Day11 do
  alias AdventOfCode2024.Helpers

  require Integer

  def part_a([line]) do
    line
    |> parse_input()
    |> n_steps(25)
    |> Map.values()
    |> Enum.sum()
  end

  def parse_input(line) do
    line
    |> String.split()
    |> Map.new(&{String.to_integer(&1), 1})
  end

  defp n_steps(num_map, n) do
    Enum.reduce(1..n, num_map, fn _, acc -> one_step(acc) end)
  end

  def one_step(num_map) do
    num_map
    |> Enum.flat_map(fn {key, value} -> mutate_key_value(key, value) end)
    |> Helpers.merge_maps_with_sum()
  end

  defp mutate_key_value(key, value) do
    key
    |> mutate()
    |> Enum.map(&%{&1 => value})
  end

  def mutate(0), do: [1]

  def mutate(x) do
    x_string = Integer.to_string(x)
    x_string_length = String.length(x_string)

    if Integer.is_even(x_string_length) do
      x_string
      |> String.split_at(div(x_string_length, 2))
      |> Tuple.to_list()
      |> Enum.map(&String.to_integer/1)
    else
      [x * 2024]
    end
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day11.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day11.txt")
    |> part_b()
  end
end
