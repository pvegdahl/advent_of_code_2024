defmodule AdventOfCode2024.Day22Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day22

  test "Day22 part A example" do
    assert Day22.part_a(example_input()) == 37_327_623
  end

  defp example_input() do
    """
    1
    10
    100
    2024
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day22 part B example" do
    assert Day22.part_b(example_input()) == 42
  end
end
