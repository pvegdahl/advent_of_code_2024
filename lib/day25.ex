defmodule AdventOfCode2024.Day25 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    %{keys: keys, locks: locks} = parse_input(lines)

    for key <- keys, lock <- locks do
      not overlap?(key, lock)
    end
    |> Enum.count(&Function.identity/1)
  end

  def parse_input(lines) do
    chunks =
      lines
      |> Enum.chunk_by(fn line -> line == "" end)
      |> Enum.reject(fn line_group -> line_group == [""] end)

    %{key: key_chunks, lock: lock_chunks} = Enum.group_by(chunks, &chunk_type/1)

    locks = Enum.map(lock_chunks, &parse_lock_or_key/1)
    keys = Enum.map(key_chunks, &parse_lock_or_key/1)

    %{locks: locks, keys: keys}
  end

  defp chunk_type(["#####" | _]), do: :lock
  defp chunk_type(_), do: :key

  defp parse_lock_or_key(lines) do
    lines
    |> Enum.map(&String.codepoints/1)
    |> Enum.zip_reduce([], fn elements, acc ->
      [Enum.count(elements, &(&1 == "#")) - 1 | acc]
    end)
    |> Enum.reverse()
  end

  defp overlap?(key, lock) do
    [key, lock]
    |> Enum.zip()
    |> Enum.any?(fn {k, l} -> k + l > 5 end)
  end

  def part_b(_lines) do
    -1
  end

  def a() do
    Helpers.file_to_lines!("inputs/day25.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day25.txt")
    |> part_b()
  end
end
