defmodule AdventOfCode2024.Day03 do
  def part_a(text) do
    text
    |> parse_numbers()
    |> Enum.map(fn [a, b] -> a * b end)
    |> Enum.sum()
  end

  def parse_numbers(text) do
    Regex.scan(~r/mul\((\d+),(\d+)\)/, text)
    |> Enum.map(fn [_full_match | num_strings] -> Enum.map(num_strings, &String.to_integer/1) end)
  end

  def part_b(text) do
    text
    |> ignore_some_text()
    |> part_a()
  end

  def ignore_some_text(text) do
    do_and_dont_indexes_set =
      Regex.scan(~r/do/, text, return: :index)
      |> Enum.map(fn [{index, _}] -> index end)
      |> MapSet.new()

    dont_indexes_set =
      Regex.scan(~r/don't/, text, return: :index)
      |> Enum.map(fn [{index, _}] -> index end)
      |> MapSet.new()

    do_indexes_set = MapSet.difference(do_and_dont_indexes_set, dont_indexes_set)

    do_indexes = [0 | Enum.sort(do_indexes_set)]
    dont_indexes = Enum.sort(dont_indexes_set)

    do_sections(text, do_indexes, dont_indexes)
  end

  defp do_sections(text, [do_head | _do_tail], [] = _dont) do
    String.slice(text, do_head..-1//1)
  end

  defp do_sections(text, [do_head | do_tail], [dont_head | dont_tail]) do
    partial_text = String.slice(text, do_head..(dont_head - 1))

    next_do = Enum.drop_while(do_tail, &(&1 < dont_head))

    case next_do do
      [] ->
        partial_text

      [next_do_head | _] ->
        next_dont = Enum.drop_while(dont_tail, &(&1 < next_do_head))
        partial_text <> do_sections(text, next_do, next_dont)
    end
  end

  def a() do
    File.read!("inputs/day03.txt")
    |> part_a()
  end

  def b() do
    File.read!("inputs/day03.txt")
    |> part_b()
  end
end
