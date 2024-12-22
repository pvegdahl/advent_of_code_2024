defmodule AdventOfCode2024.Day19Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day19

  test "Day19 part A example" do
    assert Day19.part_a(example_input()) == 6
  end

  defp example_input() do
    """
    r, wr, b, g, bwu, rb, gb, br

    brwrr
    bggr
    gbbr
    rrbgbr
    ubwu
    bwurrg
    brgr
    bbrgwb
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day19 part B example" do
    assert Day19.part_b(example_input()) == 42
  end
end
