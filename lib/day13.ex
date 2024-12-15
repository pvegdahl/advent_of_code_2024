defmodule AdventOfCode2024.Day13 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    lines
    |> parse_input()
    |> Enum.map(&solve_ab/1)
    |> Enum.reject(&(&1 == :impossible))
    |> Enum.map(&cost/1)
    |> Enum.sum()
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

  defp cost({a, b}), do: 3 * a + b

  defp add_1e13_to_prize_location(%{prize: {prize_x, prize_y}} = claw_setup) do
    %{claw_setup | prize: {prize_x + 10_000_000_000_000, prize_y + 10_000_000_000_000}}
  end

  def part_b(lines) do
    lines
    |> parse_input()
    |> Enum.map(&add_1e13_to_prize_location/1)
    |> Enum.map(&solve_ab/1)
    |> Enum.reject(&(&1 == :impossible))
    |> Enum.map(&cost/1)
    |> Enum.sum()
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
