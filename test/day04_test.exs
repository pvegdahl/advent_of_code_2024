defmodule AdventOfCode2024.Day04Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day04

  @tag :skip
  test "Day04 part A example" do
    assert Day04.part_a(example_input()) == :something
  end

  defp example_input() do
    """
    TODO
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day04 part B example" do
    assert Day04.part_b(example_input()) == :something_else
  end
end
