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

  @tag :skip
  test "Day22 part B example" do
    assert Day22.part_b(example_input()) == 42
  end
end
