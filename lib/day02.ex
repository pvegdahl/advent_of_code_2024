defmodule AdventOfCode2024.Day02 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    lines
    |> Enum.map(&Helpers.string_to_int_list/1)
    |> Enum.count(&safe?/1)
  end

  defp safe?(levels) do
    case direction(levels) do
      :flat -> false
      :increasing -> small_increases?(levels)
      :decreasing -> levels |> Enum.reverse() |> small_increases?()
    end
  end

  defp direction([a, a | _]), do: :flat
  defp direction([a, b | _]) when a < b, do: :increasing
  defp direction([a, b | _]) when a > b, do: :decreasing

  defp small_increases?([_]), do: true

  defp small_increases?([a, b | rest]) do
    diff = b - a
    diff >= 1 and diff <= 3 and small_increases?([b | rest])
  end

  def part_b(lines) do
    lines
    |> Enum.map(&Helpers.string_to_int_list/1)
    |> Enum.count(fn levels -> safe?(levels) or safe_with_removal?(levels) end)
  end

  defp safe_with_removal?(levels) do
    size = Enum.count(levels)

    0..(size - 1)
    |> Stream.map(&List.delete_at(levels, &1))
    |> Enum.any?(&safe?/1)
  end

  def a() do
    Helpers.file_to_lines!("inputs/day02.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day02.txt")
    |> part_b()
  end
end
