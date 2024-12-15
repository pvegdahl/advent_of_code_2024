defmodule AdventOfCode2024.Day14Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day14

  test "Day14 part A example" do
    assert Day14.part_a(example_input(), {11, 7}) == 12
  end

  defp example_input() do
    """
    p=0,4 v=3,-3
    p=6,3 v=-1,-3
    p=10,3 v=-1,2
    p=2,0 v=2,-1
    p=0,0 v=1,3
    p=3,0 v=-2,-2
    p=7,6 v=-1,-3
    p=3,0 v=-1,-2
    p=9,3 v=2,3
    p=7,3 v=-1,2
    p=2,4 v=2,-3
    p=9,5 v=-3,-3
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  describe "parse_input/1" do
    test "example input" do
      assert [
               %{location: {0, 4}, velocity: {3, -3}},
               %{location: {6, 3}, velocity: {-1, -3}},
               %{location: {10, 3}, velocity: {-1, 2}},
               %{location: {2, 0}, velocity: {2, -1}} | _
             ] = Day14.parse_input(example_input())
    end
  end

  describe "move/3" do
    test "two points, single iteration" do
      assert Day14.move(
               [
                 %{location: {0, 4}, velocity: {3, -3}},
                 %{location: {6, 3}, velocity: {-1, -3}}
               ],
               {11, 7},
               1
             ) == [
               %{location: {3, 1}, velocity: {3, -3}},
               %{location: {5, 0}, velocity: {-1, -3}}
             ]
    end

    test "two points, 10 iterations to cause wrapping" do
      assert Day14.move(
               [
                 %{location: {0, 4}, velocity: {3, -3}},
                 %{location: {6, 3}, velocity: {-1, -3}}
               ],
               {11, 7},
               10
             ) == [
               %{location: {8, 2}, velocity: {3, -3}},
               %{location: {7, 1}, velocity: {-1, -3}}
             ]
    end
  end

  # No part B test
end
