defmodule AdventOfCode2024.Day13Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day13

  test "Day13 part A example" do
    assert Day13.part_a(example_input()) == 480
  end

  defp example_input() do
    """
    Button A: X+94, Y+34
    Button B: X+22, Y+67
    Prize: X=8400, Y=5400

    Button A: X+26, Y+66
    Button B: X+67, Y+21
    Prize: X=12748, Y=12176

    Button A: X+17, Y+86
    Button B: X+84, Y+37
    Prize: X=7870, Y=6450

    Button A: X+69, Y+23
    Button B: X+27, Y+71
    Prize: X=18641, Y=10279
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  describe "parse_input" do
    test "example_input" do
      assert [
               %{a: {94, 34}, b: {22, 67}, prize: {8400, 5400}},
               %{a: {26, 66}, b: {67, 21}, prize: {12748, 12176}},
               %{a: {17, 86}, b: {84, 37}, prize: {7870, 6450}},
               %{a: {69, 23}, b: {27, 71}, prize: {18641, 10279}}
             ] = Day13.parse_input(example_input())
    end
  end

  describe "solve_ab" do
    test "Example 1 is solvable" do
      assert Day13.solve_ab(%{a: {94, 34}, b: {22, 67}, prize: {8400, 5400}}) == {80, 40}
    end

    test "Example 2 is impossible" do
      assert Day13.solve_ab(%{a: {26, 66}, b: {67, 21}, prize: {12748, 12176}}) == :impossible
    end

    test "Example 3 is solvable" do
      assert Day13.solve_ab(%{a: {17, 86}, b: {84, 37}, prize: {7870, 6450}}) == {38, 86}
    end

    test "Example 4 is impossible" do
      assert Day13.solve_ab(%{a: {69, 23}, b: {27, 71}, prize: {18641, 10279}}) == :impossible
    end
  end

  describe "solve_ab part_b" do
    test "Example 1 is impossible" do
      assert Day13.solve_ab(%{a: {94, 34}, b: {22, 67}, prize: {10_000_000_008_400, 10_000_000_005_400}}) == :impossible
    end

    test "Example 2 is solvable" do
      refute Day13.solve_ab(%{a: {26, 66}, b: {67, 21}, prize: {10_000_000_012_748, 10_000_000_012_176}}) == :impossible
    end

    test "Example 3 is impossible" do
      assert Day13.solve_ab(%{a: {17, 86}, b: {84, 37}, prize: {10_000_000_007_870, 10_000_000_006_450}}) == :impossible
    end

    test "Example 4 is solvable" do
      refute Day13.solve_ab(%{a: {69, 23}, b: {27, 71}, prize: {10_000_000_018_641, 10_000_000_010_279}}) == :impossible
    end
  end
end
