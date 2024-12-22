defmodule AdventOfCode2024.Day09 do
  alias AdventOfCode2024.Helpers

  def part_a([line]) do
    line
    |> compact()
    |> Enum.with_index()
    |> Enum.map(fn {file_id, index} -> file_id * index end)
    |> Enum.sum()
  end

  def compact(line) do
    line
    |> setup_queue()
    |> compact([])
    |> Enum.reverse()
  end

  defp compact(q0, acc) do
    case :queue.out(q0) do
      {:empty, _q} -> acc
      {{:value, nil}, q1} -> move_from_end(q1, acc)
      {{:value, value}, q1} -> compact(q1, [value | acc])
    end
  end

  defp move_from_end(q0, acc) do
    case :queue.out_r(q0) do
      {:empty, _q} -> acc
      {{:value, nil}, q1} -> move_from_end(q1, acc)
      {{:value, value}, q1} -> compact(q1, [value | acc])
    end
  end

  def setup_queue(line) do
    num_pairs =
      line
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2, 2, [0])
      |> Enum.with_index()

    Enum.reduce(num_pairs, :queue.new(), fn {[file_size, empty_size], file_id}, q ->
      items = List.duplicate(file_id, file_size) ++ List.duplicate(nil, empty_size)
      push_many(q, items)
    end)
  end

  defp push_many(queue, items), do: Enum.reduce(items, queue, fn item, qq -> :queue.in(item, qq) end)

  def part_b([_line]) do
    -1
  end

  def setup_queue_b(line) do
    num_pairs =
      line
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2, 2, [0])
      |> Enum.with_index()

    Enum.reduce(num_pairs, :queue.new(), fn {[file_size, empty_size], file_id}, q ->
      if empty_size > 0 do
        push_many(q, [{file_id, file_size}, {nil, empty_size}])
      else
        :queue.in({file_id, file_size}, q)
      end
    end)
  end

  def a() do
    Helpers.file_to_lines!("inputs/day09.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day09.txt")
    |> part_b()
  end
end
