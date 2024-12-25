defmodule AdventOfCode2024.Day16Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day16

  test "Day16 part A example" do
    assert Day16.part_a(example_input()) == 11048
  end

  defp example_input() do
    """
    #################
    #...#...#...#..E#
    #.#.#.#.#.#.#.#.#
    #.#.#.#...#...#.#
    #.#.#.#.###.#.#.#
    #...#.#.#.....#.#
    #.#.#.#.#.#####.#
    #.#...#.#.#.....#
    #.#.#####.#.###.#
    #.#.#.......#...#
    #.#.###.#####.###
    #.#.#...#.....#.#
    #.#.#.#####.###.#
    #.#.#.........#.#
    #.#.#.#########.#
    #S#.............#
    #################
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  test "input_to_graph" do
    expected_graph =
      Graph.new(type: :undirected)
      |> Graph.add_edge({1, 1, :horizontal}, {2, 1, :horizontal}, weight: 1)
      |> Graph.add_edge({1, 2, :horizontal}, {2, 2, :horizontal}, weight: 1)
      |> Graph.add_edge({1, 1, :vertical}, {1, 2, :vertical}, weight: 1)
      |> Graph.add_edge({2, 1, :vertical}, {2, 2, :vertical}, weight: 1)
      |> Graph.add_edge({1, 1, :horizontal}, {1, 1, :vertical}, weight: 1000)
      |> Graph.add_edge({1, 2, :horizontal}, {1, 2, :vertical}, weight: 1000)
      |> Graph.add_edge({2, 1, :horizontal}, {2, 1, :vertical}, weight: 1000)
      |> Graph.add_edge({2, 2, :horizontal}, {2, 2, :vertical}, weight: 1000)

    assert %{start: {1, 2, :horizontal}, target: {2, 1}, graph: ^expected_graph} =
             Day16.input_to_graph(["####", "#.E#", "#S.#", "####"])
  end

  test "Day16 part B example" do
    assert Day16.part_b(example_input()) == 64
  end
end
