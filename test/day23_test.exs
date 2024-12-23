defmodule AdventOfCode2024.Day23Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day23

  test "Day23 part A example" do
    assert Day23.part_a(example_input()) == 7
  end

  defp example_input() do
    """
    kh-tc
    qp-kh
    de-cg
    ka-co
    yn-aq
    qp-ub
    cg-tb
    vc-aq
    tb-ka
    wh-tc
    yn-cg
    kh-ub
    ta-co
    de-co
    tc-td
    tb-wq
    wh-td
    ta-ka
    td-qp
    aq-cg
    wq-ub
    ub-vc
    de-ta
    wq-aq
    wq-vc
    wh-yn
    ka-de
    kh-ta
    co-tc
    wh-qp
    tb-vc
    td-yn
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @tag :skip
  test "Day23 part B example" do
    assert Day23.part_b(example_input()) == 42
  end
end
