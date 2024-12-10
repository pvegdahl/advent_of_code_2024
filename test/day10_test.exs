defmodule AdventOfCode2024.Day10Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day10

  test "Day10 part A example" do
    assert Day10.part_a(example_input()) == 36
  end

  defp example_input() do
    """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day10 part B example" do
    assert Day10.part_b(example_input()) == :something_else
  end
end
