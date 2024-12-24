defmodule AdventOfCode2024.Day24 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    state = parse_input(lines)

    state
    |> Map.keys()
    |> Enum.filter(&String.starts_with?(&1, "z"))
    |> Enum.sort(:desc)
    |> Enum.map(fn key -> solve_for(key, state) end)
    |> Integer.undigits(2)
  end

  def parse_input(lines) do
    {initial_state_lines, ["" | logic_gate_lines]} = Enum.split_while(lines, &(&1 != ""))

    initial_states =
      Enum.map(initial_state_lines, fn line ->
        [wire, state_string] = String.split(line, ": ")
        {wire, String.to_integer(state_string)}
      end)

    logic_gates =
      Enum.map(logic_gate_lines, fn line ->
        [input0, gate_string, input2, _, output] = String.split(line)
        {output, {parse_gate(gate_string), input0, input2}}
      end)

    Map.new(initial_states ++ logic_gates)
  end

  defp parse_gate("XOR"), do: :xor
  defp parse_gate("OR"), do: :or
  defp parse_gate("AND"), do: :and

  def solve_for(target, state) do
    case Map.get(state, target) do
      {operand, input0, input1} ->
        value0 = solve_for(input0, state)
        value1 = solve_for(input1, state)
        operate(operand, value0, value1)

      value ->
        value
    end
  end

  defp operate(:and, a, b), do: Bitwise.band(a, b)
  defp operate(:or, a, b), do: Bitwise.bor(a, b)
  defp operate(:xor, a, b), do: Bitwise.bxor(a, b)

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day24.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day24.txt")
    |> part_b()
  end
end
