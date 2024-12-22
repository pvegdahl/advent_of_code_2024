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

  def part_b(lines) do
    lines
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&change_sequence(&1, 2000))
    |> try_everything()
  end

  def change_sequence(secret_number, n) do
    secret_number
    |> Stream.iterate(&one_iteration/1)
    |> Stream.map(&Integer.mod(&1, 10))
    |> Stream.chunk_every(2, 1)
    |> Stream.map(fn [previous, current] -> {current, current - previous} end)
    |> Enum.take(n)
  end

  def score_one_bid(change_sequences, bid_sequence) do
    change_sequences
    |> Enum.map(&bid(&1, bid_sequence))
    |> Enum.sum()
  end

  defp all_bid_sequences do
    for a <- -9..9, b <- -9..9, c <- -9..9, d <- -9..9, do: [a, b, c, d]
  end

  def bid([_, _, _], _bid_sequence), do: 0
  def bid([{_, a}, {_, b}, {_, c}, {bananas, d} | _], [a, b, c, d]), do: bananas
  def bid([_head | tail], bid_sequence), do: bid(tail, bid_sequence)

  defp try_everything(change_sequences) do
    all_bid_sequences()
    |> Enum.map(&score_one_bid(change_sequences, &1))
    |> Enum.max()
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
