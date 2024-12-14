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
               _,
               _
             ] = Day13.parse_input(example_input())
    end
  end

  @tag :skip
  test "Day13 part B example" do
    assert Day13.part_b(example_input()) == :something_else
  end
end
