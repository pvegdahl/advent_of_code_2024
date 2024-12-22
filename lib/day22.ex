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

  def part_b(lines, threshold) do
    change_sequences =
      lines
      |> Enum.map(&String.to_integer/1)
      |> Enum.map(&change_sequence(&1, 2000))

    bid_sequences = likely_bid_sequences(change_sequences, threshold)

    chunk_size = Enum.count(bid_sequences) |> div(11)

    bid_sequences
    |> Enum.chunk_every(chunk_size)
    |> Task.async_stream(fn chunk -> one_chunk(change_sequences, chunk) end, timeout: :infinity)
    |> Enum.map(fn {:ok, result} -> result end)
    |> Enum.max()
  end

  defp one_chunk(change_sequences, bid_sequence_chunk) do
    bid_sequence_chunk
    |> Enum.map(&score_one_bid(change_sequences, &1))
    |> Enum.max()
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

  defp likely_bid_sequences(change_sequences, threshold) do
    # There are ~40k unique sequences in the 2K lists. A number of them show up > 300 times. Most show up less than 200.
    # Let's focus on the likely ones that show up at least <threshold> times.
    change_sequences
    |> Enum.flat_map(&bid_sequences_for_one_list/1)
    |> Enum.frequencies()
    |> Enum.reject(fn {_key, value} -> value < threshold end)
    |> Enum.map(fn {key, _value} -> key end)
  end

  defp bid_sequences_for_one_list(change_sequence) do
    change_sequence
    |> Enum.map(&elem(&1, 1))
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.uniq()
  end

  def bid([_, _, _], _bid_sequence), do: 0
  def bid([{_, a}, {_, b}, {_, c}, {bananas, d} | _], [a, b, c, d]), do: bananas
  def bid([_head | tail], bid_sequence), do: bid(tail, bid_sequence)

  def a() do
    Helpers.file_to_lines!("inputs/day22.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day22.txt")
    |> part_b(200)
  end
end
