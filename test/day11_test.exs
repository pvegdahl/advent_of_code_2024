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

  @tag :skip
  test "Day11 part B example" do
    assert Day11.part_b(example_input()) == :something_else
  end
end
