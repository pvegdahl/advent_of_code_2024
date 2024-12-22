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
    change_sequences =
      lines
      |> Enum.map(&String.to_integer/1)
      |> Enum.map(&change_sequence(&1, 2000))

    bid_sequences_by_list = bid_sequences_for_all_lists(change_sequences)
    bid_sequences = bid_sequences_sorted_by_frequency(bid_sequences_by_list)

    find_best_score(bid_sequences_by_list, bid_sequences)
  end

  defp bid_sequences_sorted_by_frequency(bid_sequences_by_list) do
    bid_sequences_by_list
    |> Enum.flat_map(&Map.keys/1)
    |> Enum.frequencies()
    |> Enum.sort_by(fn {_key, value} -> value end, :desc)
  end

  defp find_best_score(bid_sequences_by_list, bid_sequences) do
    # Bid sequences are ordered by descending frequency. # If a sequence shows up N times, then the largest possible
    # score is N * 9. Once we dip below that threshold, no need to keep trying sequences.
    Enum.reduce_while(bid_sequences, 0, fn {bid_sequence, frequency}, best_score ->
      max_possible_score = frequency * 9

      if best_score > max_possible_score do
        {:halt, best_score}
      else
        {:cont, max(best_score, score_one_bid(bid_sequences_by_list, bid_sequence))}
      end
    end)
  end

  def change_sequence(secret_number, n) do
    secret_number
    |> Stream.iterate(&one_iteration/1)
    |> Stream.map(&Integer.mod(&1, 10))
    |> Stream.chunk_every(2, 1)
    |> Stream.map(fn [previous, current] -> {current, current - previous} end)
    |> Enum.take(n)
  end

  def score_one_bid(bid_sequences_by_list, bid_sequence) do
    bid_sequences_by_list
    |> Enum.map(&Map.get(&1, bid_sequence, 0))
    |> Enum.sum()
  end

  defp bid_sequences_for_all_lists(change_sequences) do
    Enum.map(change_sequences, &bid_sequences_for_one_list/1)
  end

  defp bid_sequences_for_one_list(change_sequence) do
    change_sequence
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.map(fn [{_, a}, {_, b}, {_, c}, {value, d}] -> {{a, b, c, d}, value} end)
    |> Enum.uniq_by(fn {key, _value} -> key end)
    |> Map.new()
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
    |> part_b()
  end
end
