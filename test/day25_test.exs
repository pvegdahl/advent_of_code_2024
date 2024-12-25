defmodule AdventOfCode2024.Day25Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day25

  test "Day25 part A example" do
    assert Day25.part_a(example_input()) == 3
  end

  defp example_input() do
    """
    #####
    .####
    .####
    .####
    .#.#.
    .#...
    .....

    #####
    ##.##
    .#.##
    ...##
    ...#.
    ...#.
    .....

    .....
    #....
    #....
    #...#
    #.#.#
    #.###
    #####

    .....
    .....
    #.#..
    ###..
    ###.#
    ###.#
    #####

    .....
    .....
    .....
    #....
    #.#..
    #.#.#
    #####
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  describe "parse_input/1" do
    test "example_input" do
      assert %{
               locks: [[0, 5, 3, 4, 3], [1, 2, 0, 5, 3]],
               keys: [[5, 0, 2, 1, 3], [4, 3, 4, 0, 2], [3, 0, 2, 0, 1]]
             } == Day25.parse_input(example_input())
    end
  end

  @tag :skip
  test "Day25 part B example" do
    assert Day25.part_b(example_input()) == 42
  end
end
