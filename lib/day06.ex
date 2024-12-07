defmodule AdventOfCode2024.Day06 do
  alias AdventOfCode2024.Helpers

  def part_a(_lines) do
  end

  def parse_input(lines) do
    boxes =
      lines
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, y_index} -> boxes_in_line(line, y_index) end)
      |> MapSet.new()

    {start_location(lines), boxes}
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

    {x_index, y_index}
  end

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
