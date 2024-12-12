defmodule AdventOfCode2024.Day11Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day11

  test "Day11 part A example" do
    assert Day11.part_a(example_input()) == 55312
  end

  defp example_input() do
    "125 17"
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  describe "parse_input/1" do
    test "makes a map to 1's" do
      assert Day11.parse_input("1 2 3") == %{1 => 1, 2 => 1, 3 => 1}
    end
  end

  describe "one_step" do
    test "mutates things, merges, etc" do
      assert Day11.one_step(%{20_242_024 => 3, 1 => 2, 0 => 5, 65 => 65}) == %{2024 => 8, 1 => 5, 6 => 65, 5 => 65}
    end
  end

  describe "mutate/1" do
    test "zero to one" do
      assert Day11.mutate(0) == [1]
    end

    test "1 -> 2024" do
      assert Day11.mutate(1) == [2024]
    end

    test "5 -> 5*2024" do
      assert Day11.mutate(5) == [10120]
    end

    test "100 -> 100*2024" do
      assert Day11.mutate(100) == [202_400]
    end

    test "10 -> [1, 0]" do
      assert Day11.mutate(10) == [1, 0]
    end

    test "2024 -> [20, 24]" do
      assert Day11.mutate(2024) == [20, 24]
    end

    test "1234506789 -> [12345, 6789]" do
      assert Day11.mutate(1_234_506_789) == [12345, 6789]
    end
  end

  # No part B example
end
