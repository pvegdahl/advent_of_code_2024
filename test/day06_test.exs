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

  @tag :skip
  test "Day06 part B example" do
    assert Day06.part_b(example_input()) == :something_else
  end
end
