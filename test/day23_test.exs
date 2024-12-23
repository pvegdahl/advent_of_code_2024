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

  describe "parse_input/1" do
    test "small input -- I'm not crazy enough to try to figure out the whole example input" do
      assert Day23.parse_input(["ab-cd", "ab-ef", "ab-gh", "gh-cd"]) == %{
               "ab" => MapSet.new(["cd", "ef", "gh"]),
               "cd" => MapSet.new(["ab", "gh"]),
               "ef" => MapSet.new(["ab"]),
               "gh" => MapSet.new(["ab", "cd"])
             }
    end
  end

  describe "find_triples_for/2" do
    setup do
      %{mapping: Day23.parse_input(example_input())}
    end

    test "tb has one", %{mapping: mapping} do
      assert Day23.find_triples_for("tb", mapping) == [{"tb", "vc", "wq"}]
    end

    test "ta has three", %{mapping: mapping} do
      assert Day23.find_triples_for("ta", mapping) == [{"co", "de", "ta"}, {"co", "ka", "ta"}, {"de", "ka", "ta"}]
    end
  end

  test "Day23 part B example" do
    assert Day23.part_b(example_input()) == "co,de,ka,ta"
  end
end
