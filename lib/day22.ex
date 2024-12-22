defmodule AdventOfCode2024.Day22 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    lines
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(fn num -> n_iterations(num, 2000) end)
    |> Enum.sum()
  end

  def n_iterations(secret_number, n) do
    Enum.reduce(1..n, secret_number, fn _, secret_number -> one_iteration(secret_number) end)
  end

  def one_iteration(secret_number_0) do
    secret_number_1 =
      (secret_number_0 * 64)
      |> mix(secret_number_0)
      |> prune()

    secret_number_2 =
      secret_number_1
      |> div(32)
      |> mix(secret_number_1)
      |> prune()

    secret_number_2
    |> then(&(&1 * 2048))
    |> mix(secret_number_2)
    |> prune()
  end

  defp mix(a, b), do: Bitwise.bxor(a, b)

  defp prune(num), do: Integer.mod(num, 16_777_216)

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day22.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day22.txt")
    |> part_b()
  end
end
