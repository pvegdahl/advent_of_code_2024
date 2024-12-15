defmodule AdventOfCode2024.Day12Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day12

  test "Day12 part A example" do
    assert Day12.part_a(example_input()) == 1930
  end

  defp example_input() do
    """
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  describe "score_point_group/1" do
    test "simple 1x1" do
      assert Day12.score_point_group(MapSet.new([{4, 2}])) == 4
    end

    test "simple 2x1" do
      assert Day12.score_point_group(MapSet.new([{4, 2}, {4, 3}])) == 12
    end

    test "simple 2x2" do
      assert Day12.score_point_group(MapSet.new([{4, 2}, {4, 3}, {5, 2}, {5, 3}])) == 32
    end
  end

  @tag :skip
  test "Day12 part B example" do
    assert Day12.part_b(example_input()) == :something_else
  end
end
