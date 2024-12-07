defmodule AdventOfCode2024.Day05Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day05

  test "Day05 part A example" do
    assert Day05.part_a(example_input()) == 143
  end

  defp example_input() do
    """
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  test "parse_rules/1" do
    assert Day05.parse_rules(["47|53", "97|13", "97|61", "97|47", "75|29"]) == %{
             47 => MapSet.new([53]),
             97 => MapSet.new([13, 61, 47]),
             75 => MapSet.new([29]),
             53 => MapSet.new(),
             13 => MapSet.new(),
             61 => MapSet.new(),
             29 => MapSet.new()
           }
  end

  describe "valid_order?/2" do
    setup do
      %{rules: %{4 => MapSet.new([5]), 1 => MapSet.new([2, 3, 4]), 0 => MapSet.new([1])}}
    end

    test "valid", %{rules: rules} do
      assert Day05.valid_ordering?([0, 1, 2, 4, 5], rules)
    end

    test "invalid", %{rules: rules} do
      refute Day05.valid_ordering?([5, 0, 1, 2, 4], rules)
    end

    test "example lines" do
      rules =
        Day05.parse_rules([
          "47|53",
          "97|13",
          "97|61",
          "97|47",
          "75|29",
          "61|13",
          "75|53",
          "29|13",
          "97|29",
          "53|29",
          "61|53",
          "97|53",
          "61|29",
          "47|13",
          "75|47",
          "97|75",
          "47|61",
          "75|61",
          "47|29",
          "75|13",
          "53|13"
        ])

      assert Day05.valid_ordering?([75, 47, 61, 53, 29], rules)
      assert Day05.valid_ordering?([97, 61, 53, 29, 13], rules)
      assert Day05.valid_ordering?([75, 29, 13], rules)
      refute Day05.valid_ordering?([75, 97, 47, 61, 53], rules)
      refute Day05.valid_ordering?([61, 13, 29], rules)
      refute Day05.valid_ordering?([97, 13, 75, 29, 47], rules)
    end
  end

  describe "middle_number/1" do
    test "examples" do
      assert Day05.middle_number([75, 47, 61, 53, 29]) == 61
      assert Day05.middle_number([97, 61, 53, 29, 13]) == 53
      assert Day05.middle_number([75, 29, 13]) == 29
      assert Day05.middle_number([75, 97, 47, 61, 53]) == 47
      assert Day05.middle_number([61, 13, 29]) == 13
      assert Day05.middle_number([97, 13, 75, 29, 47]) == 75
    end
  end

  test "Day05 part B example" do
    assert Day05.part_b(example_input()) == 123
  end

  describe "reorder/2" do
    test "puts numbers in the right order" do
      rules = %{
        10 => MapSet.new([9, 5, 7, 3, 1]),
        9 => MapSet.new([8, 6, 4, 2]),
        8 => MapSet.new([7, 5, 3, 1]),
        7 => MapSet.new([6, 4, 2]),
        6 => MapSet.new([5, 4, 3, 2, 1]),
        5 => MapSet.new([4, 2, 1]),
        4 => MapSet.new([3, 1]),
        3 => MapSet.new([2]),
        2 => MapSet.new([1]),
        1 => MapSet.new([])
      }

      assert Day05.reorder(Enum.to_list(1..10), rules) == Enum.to_list(10..1//-1)
    end
  end
end
