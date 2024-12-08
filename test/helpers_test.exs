defmodule AdventOfCode2024.HelpersTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Helpers

  test "A reversed map of lists with one key and one value" do
    assert Helpers.reverse_map_of_lists(%{1 => [2]}) == %{2 => [1]}
  end

  test "A reversed map of lists with two keys, each with one distinct value" do
    assert Helpers.reverse_map_of_lists(%{1 => [2], 3 => [4]}) == %{2 => [1], 4 => [3]}
  end

  test "A complex test of reversed map of lists" do
    assert Helpers.reverse_map_of_lists(%{1 => [2, 3, 4], 0 => [4, 5, 6]}) == %{
             2 => [1],
             3 => [1],
             # Note: This ordering is only guaranteed by the current Erlang implementation of small maps.
             4 => [0, 1],
             5 => [0],
             6 => [0]
           }
  end

  describe "parse_string_grid" do
    test "empty grid" do
      assert Helpers.parse_string_grid(["...", "...", "..."]) == %{}
    end

    test "non-empty grid" do
      assert Helpers.parse_string_grid(["a.b", ".a.", "bca"]) == %{
               "a" => MapSet.new([{0, 0}, {1, 1}, {2, 2}]),
               "b" => MapSet.new([{2, 0}, {0, 2}]),
               "c" => MapSet.new([{1, 2}])
             }
    end
  end

  describe "grid_dimensions" do
    test "square grid" do
      assert Helpers.grid_dimensions(["a.b", ".a.", "bca"]) == {3, 3}
    end

    test "rectangle grid" do
      assert Helpers.grid_dimensions(["a.", "..", "bc", ".."]) == {2, 4}
    end
  end
end
