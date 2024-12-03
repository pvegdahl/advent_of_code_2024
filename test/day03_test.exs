defmodule AdventOfCode2024.Day03Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day03

  test "Day03 part A example" do
    assert Day03.part_a(example_input()) == 161
  end

  defp example_input() do
    "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
  end

  test "parse simple input to numbers" do
    assert Day03.parse_numbers("mul(2,3)") == [[2, 3]]
  end

  test "parse input with junk" do
    assert Day03.parse_numbers("aksjdflasdfjmul(7,11)aksjdflasdfj") == [[7, 11]]
  end

  test "parse input with multiple muls" do
    assert Day03.parse_numbers("mul(1,2),mul(3,4)&mul(5,6)+mul[7,8]") == [[1, 2], [3, 4], [5, 6]]
  end

  test "parse input across lines" do
    assert """
           mul(1,2),mul(3,4)abc
           other_mul(5,6)other
           """
           |> Day03.parse_numbers() == [[1, 2], [3, 4], [5, 6]]
  end

  test "Day03 part B example" do
    assert Day03.part_b(example_input()) == 48
  end

  test "delete text after don't and including don't" do
    assert Day03.ignore_some_text("abcdon'tefg") == "abc"
  end

  test "delete text between don't and do, keep do, but not don't" do
    assert Day03.ignore_some_text("abcdon'tblahblahdodef") == "abcdodef"
  end

  test "multiple don't - do sections" do
    assert Day03.ignore_some_text("adon'tbdocdon'tddoe") == "adocdoe"
  end

  test "multiple don'ts in a row" do
    assert Day03.ignore_some_text("adon'tbdon'tcdon'tddoe") == "adoe"
  end

  test "multiple dos in a row" do
    assert Day03.ignore_some_text("adobdocdon'tbdon'tcdoddoedofdon'tddoe") == "adobdocdoddoedofdoe"
  end
end
