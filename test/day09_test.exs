defmodule AdventOfCode2024.Day09Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day09

  test "Day09 part A example" do
    assert Day09.part_a(example_input()) == 1928
  end

  describe "setup_queue/1" do
    test "Just one item" do
      assert Day09.setup_queue("1") |> :queue.to_list() == [0]
    end

    test "longer single item" do
      assert Day09.setup_queue("3") |> :queue.to_list() == [0, 0, 0]
    end

    test "item and blanks" do
      assert Day09.setup_queue("32") |> :queue.to_list() == [0, 0, 0, nil, nil]
    end

    test "multiple items with blanks" do
      assert Day09.setup_queue("11213") |> :queue.to_list() == [0, nil, 1, 1, nil, 2, 2, 2]
    end

    test "items with no blanks" do
      assert Day09.setup_queue("10203") |> :queue.to_list() == [0, 1, 1, 2, 2, 2]
    end
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
