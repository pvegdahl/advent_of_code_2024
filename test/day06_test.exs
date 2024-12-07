defmodule AdventOfCode2024.Day06Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day06

  test "Day06 part A example" do
    assert Day06.part_a(example_input()) == 41
  end

  defp example_input() do
    """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  describe "parse_input/1" do
    test "creates a starting_location, boxes tuple" do
      assert Day06.parse_input(example_input()) ==
               {{4, 6},
                MapSet.new([
                  {4, 0},
                  {9, 1},
                  {2, 3},
                  {7, 4},
                  {1, 6},
                  {8, 7},
                  {0, 8},
                  {6, 9}
                ])}
    end
  end

  @tag :skip
  test "Day06 part B example" do
    assert Day06.part_b(example_input()) == :something_else
  end
end
