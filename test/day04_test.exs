defmodule AdventOfCode2024.Day04Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day04

  test "Day04 part A example" do
    assert Day04.part_a(example_input()) == 18
  end

  defp example_input() do
    """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  test "simple_count/1" do
    assert Day04.simple_count(["XMASABCXMASXMAS", "XMASABCXMASXMAS"]) == 6
  end

  test "vertical" do
    assert Day04.vertical(["ABC", "EFG", "HIJ"]) == ["AEH", "BFI", "CGJ"]
  end

  test "diagonal1" do
    assert Day04.diagonal1(["ABC", "EFG", "HIJ"]) == ["H", "EI", "AFJ", "BG", "C"]
  end

  test "diagonal2" do
    assert Day04.diagonal2(["ABC", "EFG", "HIJ"]) == ["J", "GI", "CFH", "BE", "A"]
  end

  test "Day04 part B example" do
    assert Day04.part_b(example_input()) == 9
  end

  describe "is_x_mas?" do
    test "orientation 1" do
      assert {
               {"M", "X", "M"},
               {"Y", "A", "Y"},
               {"S", "Z", "S"}
             }
             |> Day04.is_x_mas?({0, 0})
    end

    test "orientation 2" do
      assert {
               {"S", "X", "M"},
               {"Y", "A", "Y"},
               {"S", "Z", "M"}
             }
             |> Day04.is_x_mas?({0, 0})
    end

    test "orientation 3" do
      assert {
               {"M", "X", "S"},
               {"Y", "A", "Y"},
               {"M", "Z", "S"}
             }
             |> Day04.is_x_mas?({0, 0})
    end

    test "orientation 4" do
      assert {
               {"S", "X", "S"},
               {"Y", "A", "Y"},
               {"M", "Z", "M"}
             }
             |> Day04.is_x_mas?({0, 0})
    end

    test "not at 0, 0" do
      assert {
               {"A", "S", "X", "S"},
               {"A", "S", "X", "S"},
               {"B", "S", "X", "S"},
               {"C", "Y", "A", "Y"},
               {"D", "M", "Z", "M"}
             }
             |> Day04.is_x_mas?({1, 2})
    end
  end
end
