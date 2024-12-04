defmodule AdventOfCode2024.Day04 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    one_way_lines = lines ++ vertical(lines) ++ diagonal1(lines) ++ diagonal2(lines)
    reverse_lines = Enum.map(one_way_lines, &String.reverse/1)
    simple_count(one_way_lines ++ reverse_lines)
  end

  def simple_count(lines) do
    lines
    |> Enum.map(fn line -> Regex.scan(~r/XMAS/, line) end)
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  def vertical(lines) do
    lines
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join/1)
  end

  def diagonal1(lines) do
    matrix =
      lines
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&List.to_tuple/1)
      |> List.to_tuple()

    Enum.map(diagonal_starting_points(matrix), &diagonal_at(matrix, &1))
  end

  defp diagonal_starting_points(matrix) do
    max_x = tuple_size(elem(matrix, 0)) - 1
    max_y = tuple_size(matrix) - 1

    y_side_points = Enum.map(max_y..1//-1, &{0, &1})
    x_side_points = Enum.map(0..max_x, &{&1, 0})

    y_side_points ++ x_side_points
  end

  defp diagonal_at(matrix, point) do
    diagonal1_points(point)
    |> Stream.map(fn point -> tuple_matrix_get(matrix, point) end)
    |> Enum.take_while(&(not is_nil(&1)))
    |> Enum.join()
  end

  defp diagonal1_points(start), do: Stream.iterate(start, fn {x, y} -> {x + 1, y + 1} end)

  defp tuple_matrix_get(matrix, point, default \\ nil)
  defp tuple_matrix_get(matrix, {_x, y}, default) when y >= tuple_size(matrix), do: default
  defp tuple_matrix_get(matrix, {x, y}, default) when x >= tuple_size(elem(matrix, y)), do: default
  defp tuple_matrix_get(matrix, {x, y}, _default), do: matrix |> elem(y) |> elem(x)

  def diagonal2(lines) do
    lines
    |> Enum.map(&String.reverse/1)
    |> diagonal1()
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day04.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day04.txt")
    |> part_b()
  end
end
