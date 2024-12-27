defmodule AdventOfCode2024.Day24 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    state = parse_input(lines)

    state
    |> values_for("z")
    |> Integer.undigits(2)
  end

  def values_for(state, starting_letter) do
    state
    |> Map.keys()
    |> Enum.filter(&String.starts_with?(&1, starting_letter))
    |> Enum.sort(:desc)
    |> Enum.map(fn key -> solve_for(key, state) end)
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

  def part_b(lines) do
    state = parse_input(lines)

    diffs = diffs(state)
    Enum.each(diffs, fn {i, expected, got} -> IO.puts("#{i}: Expected #{expected}, got #{got}") end)

    new_subgates(state) |> Enum.sort() |> IO.inspect()
    :ok
  end

  defp diffs(state) do
    x = values_for(state, "x")
    y = values_for(state, "y")
    z = values_for(state, "z") |> Enum.reverse() |> Enum.with_index()

    expected =
      (Integer.undigits(x, 2) + Integer.undigits(y, 2)) |> Integer.digits(2) |> Enum.reverse() |> Enum.with_index()

    Enum.zip(expected, z)
    |> Enum.filter(fn {a, b} -> a != b end)
    |> Enum.map(fn {{a, i}, {b, i}} -> {i, a, b} end)
  end

  def subgates(state, gate) do
    state
    |> subgates_recursive(gate)
    |> MapSet.new()
  end

  defp subgates_recursive(state, gate) do
    case Map.get(state, gate) do
      {_op, a, b} ->
        [a, b] ++ Enum.flat_map([a, b], fn x -> subgates_recursive(state, x) end)

      _value ->
        []
    end
  end

  def new_subgates(state) do
    z_keys = state |> Map.keys() |> Enum.filter(&String.starts_with?(&1, "z")) |> Enum.sort()

    Enum.reduce(z_keys, %{per_z: %{}, seen: MapSet.new()}, fn key, %{per_z: per_z, seen: seen} ->
      subgates_of_this_z = MapSet.difference(subgates(state, key), seen)
      new_seen = MapSet.union(seen, subgates_of_this_z)
      new_per_z = Map.put(per_z, key, subgates_of_this_z)
      %{per_z: new_per_z, seen: new_seen}
    end)
    |> Map.get(:per_z)
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
