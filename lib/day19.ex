defmodule AdventOfCode2024.Day19 do
  alias AdventOfCode2024.Helpers
  alias AdventOfCode2024.Cache

  def part_a(lines) do
    {towels, targets} = parse_input(lines)

    {:ok, cache} = Cache.init()

    targets
    |> Enum.filter(fn target -> possible?(target, towels, cache) end)
    |> Enum.count()
  end

  def parse_input([towel_line, "" | rest]) do
    towels =
      towel_line
      |> String.split(",")
      |> Enum.map(&String.trim/1)

    {towels, rest}
  end

  def possible?("", _towels, _cache), do: true

  def possible?(target, towels, cache) do
    if Cache.has_key?(cache, target) do
      Cache.get(cache, target)
    else
      result =
        towels
        |> Enum.any?(fn towel ->
          String.starts_with?(target, towel) and possible?(String.trim_leading(target, towel), towels, cache)
        end)

      Cache.put(cache, target, result)
      result
    end
  end

  def part_b(lines) do
    {towels, targets} = parse_input(lines)

    {:ok, cache} = Cache.init()

    targets
    |> Enum.map(fn target -> possibilities(target, towels, cache) end)
    |> Enum.sum()
  end

  def possibilities("", _towels, _cache), do: 1

  def possibilities(target, towels, cache) do
    if Cache.has_key?(cache, target) do
      Cache.get(cache, target)
    else
      result =
        towels
        |> Enum.map(fn towel ->
          if String.starts_with?(target, towel) do
            possibilities(String.replace_prefix(target, towel, ""), towels, cache)
          else
            0
          end
        end)
        |> Enum.sum()

      Cache.put(cache, target, result)
      result
    end
  end

  def a() do
    Helpers.file_to_lines!("inputs/day19.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day19.txt")
    |> part_b()
  end
end
