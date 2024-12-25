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

  @tag :skip
  test "Day25 part B example" do
    assert Day25.part_b(example_input()) == 42
  end
end
