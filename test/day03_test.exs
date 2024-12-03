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

  test "parse simple input to numbers" do
    assert AdventOfCode2024.Day03.parse_numbers("mul(2,3)") == [[2, 3]]
  end

  test "parse input with junk" do
    assert AdventOfCode2024.Day03.parse_numbers("aksjdflasdfjmul(7,11)aksjdflasdfj") == [[7, 11]]
  end

  test "parse input with multiple muls" do
    assert AdventOfCode2024.Day03.parse_numbers("mul(1,2),mul(3,4)&mul(5,6)+mul[7,8]") == [[1, 2], [3, 4], [5, 6]]
  end

  test "parse input across lines" do
    assert """
           mul(1,2),mul(3,4)abc
           other_mul(5,6)other
           """
           |> AdventOfCode2024.Day03.parse_numbers() == [[1, 2], [3, 4], [5, 6]]
  end

  @tag :skip
  test "Day03 part B example" do
    assert Day03.part_b(example_input()) == :something_else
  end
end
