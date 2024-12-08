defmodule AdventOfCode2024.Day07Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day07

  test "Day07 part A example" do
    assert Day07.part_a(example_input()) == 3749
  end

  defp example_input() do
    """
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day07 part B example" do
    assert Day07.part_b(example_input()) == :something_else
  end
end
