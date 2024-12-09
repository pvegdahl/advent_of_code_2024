defmodule AdventOfCode2024.Day09 do
  alias AdventOfCode2024.Helpers

  def part_a(_line) do
  end

  def setup_queue(line) do
    num_pairs =
      line
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2, 2, [0])
      |> Enum.with_index()

    Enum.reduce(num_pairs, :queue.new(), fn {[file_size, empty_size], file_id}, q ->
      (List.duplicate(file_id, file_size) ++ List.duplicate(nil, empty_size))
      |> Enum.reduce(q, fn item, qq -> :queue.in(item, qq) end)
    end)
  end

  def part_b(_line) do
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
