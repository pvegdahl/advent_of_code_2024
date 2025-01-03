defmodule AdventOfCode2024.Day24Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2024.Day24

  test "Day24 part A example" do
    assert Day24.part_a(example_input()) == 2024
  end

  defp example_input() do
    """
    x00: 1
    x01: 0
    x02: 1
    x03: 1
    x04: 0
    y00: 1
    y01: 1
    y02: 1
    y03: 1
    y04: 1

    ntg XOR fgs -> mjb
    y02 OR x01 -> tnw
    kwq OR kpj -> z05
    x00 OR x03 -> fst
    tgd XOR rvg -> z01
    vdt OR tnw -> bfw
    bfw AND frj -> z10
    ffh OR nrd -> bqk
    y00 AND y03 -> djm
    y03 OR y00 -> psh
    bqk OR frj -> z08
    tnw OR fst -> frj
    gnj AND tgd -> z11
    bfw XOR mjb -> z00
    x03 OR x00 -> vdt
    gnj AND wpb -> z02
    x04 AND y00 -> kjc
    djm OR pbm -> qhw
    nrd AND vdt -> hwm
    kjc AND fst -> rvg
    y04 OR y02 -> fgs
    y01 AND x02 -> pbm
    ntg OR kjc -> kwq
    psh XOR fgs -> tgd
    qhw XOR tgd -> z09
    pbm OR djm -> kpj
    x03 XOR y03 -> ffh
    x00 XOR y04 -> ntg
    bfw OR bqk -> z06
    nrd XOR fgs -> wpb
    frj XOR qhw -> z04
    bqk OR frj -> z07
    y03 OR x01 -> nrd
    hwm AND bqk -> z03
    tgd XOR rvg -> z12
    tnw OR pbm -> gnj
    """
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  describe "parse_input/1" do
    test "turns the input into a map of rules" do
      assert %{
               "y03" => 1,
               "y04" => 0,
               "mjb" => {:xor, "ntg", "fgs"},
               "tnw" => {:or, "y02", "x01"},
               "tow" => {:and, "y02", "x01"}
             } =
               Day24.parse_input([
                 "y03: 1",
                 "y04: 0",
                 "",
                 "ntg XOR fgs -> mjb",
                 "y02 OR x01 -> tnw",
                 "y02 AND x01 -> tow"
               ])
    end
  end

  describe "solve_for/3" do
    setup do
      %{state: Day24.parse_input(example_input())}
    end

    test "simple initial state value", %{state: state} do
      assert Day24.solve_for("x03", state) == 1
    end

    test "solve for an OR", %{state: state} do
      assert Day24.solve_for("tnw", state) == 1
    end

    test "complicated recursive one", %{state: state} do
      assert Day24.solve_for("z00", state) == 0
    end

    test "complicated recursive one with AND", %{state: state} do
      assert Day24.solve_for("z10", state) == 1
    end
  end

  describe "subgates/2 or new_subgates/1" do
    setup do
      %{
        state: %{
          "z00" => {:xor, "x00", "y00"},
          "x00" => 1,
          "y00" => 0,
          "x01" => 0,
          "y01" => 1,
          "abc" => {:and, "x00", "y00"},
          "efg" => {:xor, "x01", "y01"},
          "z01" => {:xor, "abc", "efg"}
        }
      }
    end

    test "z00", %{state: state} do
      assert Day24.subgates(state, "z00") == MapSet.new(["x00", "y00"])
    end

    test "z01", %{state: state} do
      assert Day24.subgates(state, "z01") == MapSet.new(["x00", "y00", "x01", "y01", "abc", "efg"])
    end

    test "new_subgates/1", %{state: state} do
      assert Day24.new_subgates(state) == %{
               "z00" => MapSet.new(["x00", "y00"]),
               "z01" => MapSet.new(["x01", "y01", "abc", "efg"])
             }
    end
  end

  @tag :skip
  test "Day24 part B example" do
    assert Day24.part_b(example_input()) == 42
  end
end
