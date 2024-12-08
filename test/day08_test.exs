defmodule AdventOfCode2024.Day08Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day08

  test "Day08 part A example" do
    assert Day08.part_a(example_input()) == 14
  end

  defp example_input() do
    """
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  describe "antinodes A" do
    test "2 antennas, in bound antinodes" do
      dimensions = {10, 10}
      antennas = MapSet.new([{4, 3}, {5, 5}])
      assert Day08.antinodes(antennas, dimensions, &Day08.pair_to_antinodes_a/2) == MapSet.new([{3, 1}, {6, 7}])
    end

    test "3 antennas, some antinodes out of bounds" do
      dimensions = {10, 10}
      antennas = MapSet.new([{4, 3}, {5, 5}, {8, 4}])

      assert Day08.antinodes(antennas, dimensions, &Day08.pair_to_antinodes_a/2) ==
               MapSet.new([{3, 1}, {6, 7}, {2, 6}, {0, 2}])
    end
  end

  test "Day08 part B example" do
    assert Day08.part_b(example_input()) == 34
  end

  describe "antinodes B" do
    test "3 antennas " do
      dimensions = {10, 10}
      antennas = MapSet.new([{0, 0}, {3, 1}, {1, 2}])

      assert Day08.antinodes(antennas, dimensions, &Day08.pair_to_antinodes_b/2) ==
               MapSet.new([{0, 0}, {3, 1}, {1, 2}, {5, 0}, {6, 2}, {9, 3}, {2, 4}, {3, 6}, {4, 8}])
    end
  end
end
