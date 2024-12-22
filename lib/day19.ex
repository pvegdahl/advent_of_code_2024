defmodule AdventOfCode2024.Day19 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    {towels, targets} = parse_input(lines)

    {:ok, cache} = init_cache()

    result =
      targets
      |> Enum.filter(fn target -> possible?(target, towels, cache) end)
      |> Enum.count()

    Agent.stop(cache)
    result
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
    if has_key?(cache, target) do
      get_from_cache(cache, target)
    else
      result =
        towels
        |> Enum.any?(fn towel ->
          String.starts_with?(target, towel) and possible?(String.trim_leading(target, towel), towels, cache)
        end)

      put_in_cache(cache, target, result)
      result
    end
  end

  def init_cache do
    Agent.start(fn -> %{} end)
  end

  def has_key?(cache, key) do
    Agent.get(cache, &Map.has_key?(&1, key))
  end

  def put_in_cache(cache, key, value) do
    Agent.update(cache, &Map.put(&1, key, value))
  end

  def get_from_cache(cache, key) do
    Agent.get(cache, &Map.get(&1, key))
  end

  def part_b(_lines) do
    -1
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
