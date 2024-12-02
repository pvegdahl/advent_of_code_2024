defmodule AdventOfCode2024.Day02Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day02

  test "Day02 part A example" do
    assert Day02.part_a(example_input()) == 2
  end

  defp example_input() do
    """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day02 part B example" do
    assert Day02.part_b(example_input()) == :something_else
  end
end
