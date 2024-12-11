defmodule AdventOfCode2024.Day10Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day10

  test "Day10 part A example" do
    assert Day10.part_a(example_input()) == 36
  end

  setup do
    %{grid: Day10.parse_grid(example_input())}
  end

  describe "next_steps/4" do
    test "goes from 0 to 1", %{grid: grid} do
      assert Day10.next_steps([{2, 0}], 1, grid, {8, 8}) == MapSet.new([{2, 1}, {3, 0}])
    end

    test "Handles multiple input points", %{grid: grid} do
      assert Day10.next_steps([{0, 1}, {6, 1}], 8, grid, {8, 8}) == MapSet.new([{0, 0}, {1, 1}, {0, 2}, {5, 1}])
    end
  end

  defp example_input() do
    """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  test "Day10 part B example" do
    assert Day10.part_b(example_input()) == 81
  end
end
