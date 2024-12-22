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

  describe "n_iterations" do
    test "1 x 2000" do
      assert Day22.n_iterations(1, 2000) == 8_685_429
    end

    test "10 x 2000" do
      assert Day22.n_iterations(10, 2000) == 4_700_978
    end

    test "100 x 2000" do
      assert Day22.n_iterations(100, 2000) == 15_273_692
    end

    test "2024 x 2000" do
      assert Day22.n_iterations(2024, 2000) == 8_667_524
    end
  end

  describe "one_iteration" do
    test "The examples" do
      [
        123,
        15_887_950,
        16_495_136,
        527_345,
        704_524,
        1_553_684,
        12_683_156,
        11_100_544,
        12_249_484,
        7_753_432,
        5_908_254
      ]
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.each(fn [a, b] -> assert Day22.one_iteration(a) == b end)
    end
  end

  test "Day22 part B example" do
    assert Day22.part_b(["1", "2", "3", "2024"], 1) == 23
  end

  describe "change_sequence" do
    test "123" do
      assert Day22.change_sequence(123, 9) == [
               {0, -3},
               {6, 6},
               {5, -1},
               {4, -1},
               {4, 0},
               {6, 2},
               {4, -2},
               {4, 0},
               {2, -2}
             ]
    end
  end

  describe "bid/2" do
    test "123 example" do
      change_sequence = Day22.change_sequence(123, 10)
      assert Day22.bid(change_sequence, [-1, -1, 0, 2]) == 6
    end

    test "1 example" do
      change_sequence = Day22.change_sequence(1, 2000)
      assert Day22.bid(change_sequence, [-2, 1, -1, 3]) == 7
    end

    test "2 example" do
      change_sequence = Day22.change_sequence(2, 2000)
      assert Day22.bid(change_sequence, [-2, 1, -1, 3]) == 7
    end

    test "3 example" do
      change_sequence = Day22.change_sequence(3, 2000)
      assert Day22.bid(change_sequence, [-2, 1, -1, 3]) == 0
    end

    test "2024 example" do
      change_sequence = Day22.change_sequence(2024, 2000)
      assert Day22.bid(change_sequence, [-2, 1, -1, 3]) == 9
    end
  end

  describe "score_one_bid" do
    test "AoC example" do
      change_sequences = Enum.map([1, 2, 3, 2024], &Day22.change_sequence(&1, 2000))
      assert Day22.score_one_bid(change_sequences, [-2, 1, -1, 3]) == 23
    end
  end
end
