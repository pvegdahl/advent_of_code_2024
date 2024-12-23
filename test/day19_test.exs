defmodule AdventOfCode2024.Day19Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day19
  alias AdventOfCode2024.Cache

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

  describe "parse_input" do
    test "example input" do
      assert Day19.parse_input(example_input()) ==
               {["r", "wr", "b", "g", "bwu", "rb", "gb", "br"],
                ["brwrr", "bggr", "gbbr", "rrbgbr", "ubwu", "bwurrg", "brgr", "bbrgwb"]}
    end
  end

  describe "possible?" do
    setup do
      {:ok, cache} = Cache.init()
      %{cache: cache, towels: MapSet.new(["r", "wr", "b", "g", "bwu", "rb", "gb", "br"])}
    end

    test "yes!", %{cache: cache, towels: towels} do
      assert Day19.possible?("bwurrg", towels, cache)
    end

    test "no!", %{cache: cache, towels: towels} do
      refute Day19.possible?("bbrgwb", towels, cache)
    end
  end

  @tag :skip
  test "Day19 part B example" do
    assert Day19.part_b(example_input()) == 16
  end
end
