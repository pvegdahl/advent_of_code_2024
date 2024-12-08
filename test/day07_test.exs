defmodule AdventOfCode2024.Day07Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day07

  test "Day07 part A example" do
    assert Day07.part_a(example_input()) == 3749
  end

  defp example_input() do
    """
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  describe "parse_input/1" do
    test "single line" do
      assert Day07.parse_input(["123: 1 2 3"]) == [{123, [1, 2, 3]}]
    end

    test "multiple_lines" do
      assert Day07.parse_input(["190: 10 19", "3267: 81 40 27", "83: 17 5"]) == [
               {190, [10, 19]},
               {3267, [81, 40, 27]},
               {83, [17, 5]}
             ]
    end
  end

  describe "can_do?/3" do
    test "Simple, possible input" do
      assert Day07.can_do?(190, [10, 19], [:+, :*])
    end

    test "Harder, possible input" do
      assert Day07.can_do?(292, [11, 6, 16, 20], [:+, :*])
    end

    test "impossible input" do
      refute Day07.can_do?(21037, [9, 7, 18, 13], [:+, :*])
    end

    test "possible with concat operator" do
      assert Day07.can_do?(7290, [6, 8, 6, 15], [:+, :*, :||])
    end

    test "still impossible with concat operator" do
      refute Day07.can_do?(21037, [9, 7, 18, 13], [:+, :*, :||])
    end
  end

  test "Day07 part B example" do
    assert Day07.part_b(example_input()) == 11387
  end
end
