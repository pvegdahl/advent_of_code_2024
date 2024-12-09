defmodule AdventOfCode2024.Day09Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day09

  test "Day09 part A example" do
    assert Day09.part_a(example_input()) == 1928
  end

  defp example_input() do
    "2333133121414131402"
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day09 part B example" do
    assert Day09.part_b(example_input()) == :something_else
  end
end
