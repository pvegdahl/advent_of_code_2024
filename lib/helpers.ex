defmodule AdventOfCode2024.Helpers do
  def file_to_lines!(filename) do
    File.stream!(filename, [:utf8])
    |> Enum.map(&String.trim/1)
  end

  def string_to_int_list(integers_string) do
    integers_string
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def reverse_map_of_lists(map_of_lists) do
    Map.to_list(map_of_lists)
    |> Enum.flat_map(fn {key, values} -> Enum.map(values, &{&1, key}) end)
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
    |> Map.new()
  end

  def parse_string_grid(lines) do
    lines
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y_index} -> parse_one_grid_line(line, y_index) end)
    |> Enum.group_by(fn {char, _x, _y} -> char end, fn {_char, x, y} -> {x, y} end)
    |> Map.new(fn {key, value} -> {key, MapSet.new(value)} end)
  end

  defp parse_one_grid_line(line, y_index) do
    ~r/[^\.]/
    |> Regex.scan(line, return: :index)
    |> Enum.map(fn [{x_index, _}] -> {String.at(line, x_index), x_index, y_index} end)
  end
end
