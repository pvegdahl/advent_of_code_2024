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

  describe "parse_input" do
    test "example input" do
      assert Day19.parse_input(example_input()) ==
               {["r", "wr", "b", "g", "bwu", "rb", "gb", "br"],
                ["brwrr", "bggr", "gbbr", "rrbgbr", "ubwu", "bwurrg", "brgr", "bbrgwb"]}
    end
  end

  describe "possible?" do
    setup do
      {:ok, cache} = Day19.init_cache()
      %{cache: cache, towels: MapSet.new(["r", "wr", "b", "g", "bwu", "rb", "gb", "br"])}
    end

    test "yes!", %{cache: cache, towels: towels} do
      assert Day19.possible?("bwurrg", towels, cache)
    end

    test "no!", %{cache: cache, towels: towels} do
      refute Day19.possible?("bbrgwb", towels, cache)
    end
  end

  describe "caching" do
    test "an empty cache does not have any keys" do
      {:ok, cache} = Day19.init_cache()
      refute Day19.has_key?(cache, :anything)
    end

    test "a cache has values that you put into it" do
      {:ok, cache} = Day19.init_cache()
      Day19.put_in_cache(cache, :key0, :value0)
      Day19.put_in_cache(cache, :key1, :value1)
      Day19.put_in_cache(cache, :key2, :value2)
      assert Day19.has_key?(cache, :key0)
      assert Day19.get_from_cache(cache, :key0) == :value0
      assert Day19.get_from_cache(cache, :key1) == :value1
      assert Day19.get_from_cache(cache, :key2) == :value2
    end
  end

  @tag :skip
  test "Day19 part B example" do
    assert Day19.part_b(example_input()) == 42
  end
end
