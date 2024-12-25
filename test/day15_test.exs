defmodule AdventOfCode2024.Day15Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day15

  test "Day15 part A example" do
    assert Day15.part_a(example_input()) == 10092
  end

  defp example_input() do
    """
    ##########
    #..O..O.O#
    #......O.#
    #.OO..O.O#
    #..O@..O.#
    #O#..O...#
    #O..O..O.#
    #.OO.O.OO#
    #....O...#
    ##########

    <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
    vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
    ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
    <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
    ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
    ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
    >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
    <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
    ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
    v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  describe "parse_input/1" do
    test "parses a simple (invalid) input" do
      assert Day15.parse_input(["#..", "O#@", "O.O", "", "><^v"]) == {
               %{
                 {0, 0} => "#",
                 {1, 1} => "#",
                 {0, 1} => "O",
                 {0, 2} => "O",
                 {2, 2} => "O",
                 {2, 1} => "@"
               },
               [">", "<", "^", "v"],
               {2, 1}
             }
    end
  end

  describe "move/3" do
    setup do
      {grid, _directions, _staring_point} = Day15.parse_input(example_input())
      %{grid: grid}
    end

    test "A simple move into an empty space", %{grid: grid} do
      assert {:ok, updated_grid} = Day15.move(grid, {4, 4}, "^")

      refute Map.has_key?(updated_grid, {4, 4})
      assert Map.get(updated_grid, {4, 3}) == "@"
    end

    test "Moving into a wall goes nowhere", %{grid: grid} do
      assert :error == Day15.move(grid, {1, 5}, ">")
    end

    test "Push a box into an empty space", %{grid: grid} do
      assert {:ok, updated_grid} = Day15.move(grid, {4, 4}, "<")

      refute Map.has_key?(updated_grid, {4, 4})
      assert Map.get(updated_grid, {3, 4}) == "@"
      assert Map.get(updated_grid, {2, 4}) == "O"
    end

    test "Push multiple boxes at once", %{grid: grid} do
      grid = Map.put(grid, {4, 5}, "O")
      assert {:ok, updated_grid} = Day15.move(grid, {4, 4}, "v")

      refute Map.has_key?(updated_grid, {4, 4})
      assert Map.get(updated_grid, {4, 5}) == "@"
      assert Map.get(updated_grid, {4, 6}) == "O"
      assert Map.get(updated_grid, {4, 7}) == "O"
    end

    test "Cannot push boxes through the wall", %{grid: grid} do
      grid = Map.merge(grid, %{{1, 4} => "O", {2, 4} => "O"})
      assert :error == Day15.move(grid, {4, 4}, "<")
    end
  end

  test "Day15 part B example" do
    assert Day15.part_b(example_input()) == 9021
  end

  describe "to_input_b/1" do
    test "random input" do
      assert Day15.to_input_b(%{
               {0, 0} => "#",
               {1, 1} => "#",
               {0, 1} => "O",
               {0, 2} => "O",
               {2, 2} => "O",
               {2, 1} => "@"
             }) == %{
               {0, 0} => "#",
               {1, 0} => "#",
               {2, 1} => "#",
               {3, 1} => "#",
               {0, 1} => "[",
               {1, 1} => "]",
               {0, 2} => "[",
               {1, 2} => "]",
               {4, 2} => "[",
               {5, 2} => "]",
               {4, 1} => "@"
             }
    end
  end

  describe "move/3 with double boxes" do
    setup do
      {grid, _directions, _staring_point} = Day15.parse_input(example_input())
      %{grid: Day15.to_input_b(grid)}
    end

    test "A simple move into an empty space", %{grid: grid} do
      assert {:ok, updated_grid} = Day15.move(grid, {8, 4}, "^")

      refute Map.has_key?(updated_grid, {8, 4})
      assert Map.get(updated_grid, {8, 3}) == "@"
    end

    test "Moving into a wall goes nowhere", %{grid: grid} do
      assert :error == Day15.move(grid, {3, 5}, ">")
    end

    test "Push a box left into an empty space", %{grid: grid} do
      assert {:ok, updated_grid} = Day15.move(grid, {8, 4}, "<")

      refute Map.has_key?(updated_grid, {8, 4})
      assert Map.get(updated_grid, {7, 4}) == "@"
      assert Map.get(updated_grid, {6, 4}) == "]"
      assert Map.get(updated_grid, {5, 4}) == "["
    end

    test "Push two boxes right into an empty space", %{grid: grid} do
      assert {:ok, updated_grid} =
               grid
               |> Map.put({3, 3}, "@")
               |> Day15.move({3, 3}, ">")

      refute Map.has_key?(updated_grid, {3, 3})
      assert Map.get(updated_grid, {4, 3}) == "@"
      assert Map.get(updated_grid, {5, 3}) == "["
      assert Map.get(updated_grid, {6, 3}) == "]"
      assert Map.get(updated_grid, {7, 3}) == "["
      assert Map.get(updated_grid, {8, 3}) == "]"
    end

    test "Push a box up", %{grid: grid} do
      assert {:ok, updated_grid} =
               grid
               |> Map.put({4, 4}, "@")
               |> Day15.move({4, 4}, "^")

      refute Map.has_key?(updated_grid, {4, 4})
      refute Map.has_key?(updated_grid, {5, 3})
      assert Map.get(updated_grid, {4, 3}) == "@"
      assert Map.get(updated_grid, {4, 2}) == "["
      assert Map.get(updated_grid, {5, 2}) == "]"
    end

    test "Cannot push boxes through the wall", %{grid: grid} do
      assert :error ==
               grid
               |> Map.put({6, 2}, "@")
               |> Day15.move({6, 2}, "^")
    end
  end
end
