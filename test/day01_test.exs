defmodule AdventOfCode2024.Day01Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day01

  test "Day01 part A example" do
    assert Day01.part_a(example_input()) == 11
  end

  defp example_input() do
    """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day01 part B example" do
    assert Day01.part_b(example_input()) == :something_else
  end
end
