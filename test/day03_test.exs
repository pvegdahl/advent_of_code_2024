defmodule AdventOfCode2024.Day03Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day03

  test "Day03 part A example" do
    assert Day03.part_a(example_input()) == 161
  end

  defp example_input() do
    """
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    """
    |> String.trim()
  end

  @tag :skip
  test "Day03 part B example" do
    assert Day03.part_b(example_input()) == :something_else
  end
end
