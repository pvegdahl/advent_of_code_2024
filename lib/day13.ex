defmodule AdventOfCode2024.Day13 do
  alias AdventOfCode2024.Helpers

  def part_a(_lines) do
  end

  def parse_input(lines) do
    lines
    |> Enum.chunk_every(4)
    |> Enum.map(&Enum.take(&1, 3))
    |> Enum.map(&parse_chunk/1)
  end

  defp parse_chunk([button_a_line, button_b_line, prize_line]) do
    %{
      a: parse_line(button_a_line),
      b: parse_line(button_b_line),
      prize: parse_line(prize_line)
    }
  end

  defp parse_line(line) do
    Regex.run(~r/\D+(\d+),\D+(\d+)/, line)
    |> Enum.drop(1)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def solve_ab(%{a: {ax, ay}, b: {bx, by}, prize: {prize_x, prize_y}} = claw_setup) do
    a = div(by * prize_x - bx * prize_y, by * ax - bx * ay)
    b = div(prize_y - ay * a, by)

    if valid_solution?({a, b}, claw_setup) do
      {a, b}
    else
      :impossible
    end
  end

  defp valid_solution?({a, b}, %{a: {ax, ay}, b: {bx, by}, prize: {prize_x, prize_y}}) do
    x = ax * a + bx * b
    y = ay * a + by * b

    x == prize_x and y == prize_y
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day13.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day13.txt")
    |> part_b()
  end
end
