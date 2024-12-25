defmodule AdventOfCode2024.Day15 do
  alias AdventOfCode2024.Helpers

  def part_a(lines) do
    {grid, instructions, starting_point} = parse_input(lines)

    final_grid = all_moves(grid, starting_point, instructions)

    final_grid
    |> Enum.filter(fn {_location, type} -> type == "O" end)
    |> Enum.map(fn {{x, y}, _type} -> x + 100 * y end)
    |> Enum.sum()
  end

  def parse_input(lines) do
    {grid_lines, instruction_lines} = Enum.split_while(lines, &(String.length(&1) > 0))

    type_to_points = Helpers.parse_string_grid(grid_lines)
    grid = reverse_grid_map(type_to_points)
    starting_point = Map.get(type_to_points, "@") |> Enum.at(0)

    instructions =
      instruction_lines
      |> Enum.join("")
      |> String.graphemes()

    {grid, instructions, starting_point}
  end

  defp reverse_grid_map(grid_map) do
    grid_map
    |> Enum.flat_map(fn {character, points} -> Enum.map(points, &{&1, character}) end)
    |> Map.new()
  end

  def move(grid, point, instruction) when instruction in ["<", ">"] do
    case Map.get(grid, point) do
      nil ->
        {:ok, grid}

      "#" ->
        :error

      type when type in ["@", "O", "[", "]"] ->
        target = target_point(point, instruction)

        case move(grid, target, instruction) do
          {:ok, grid_with_pushed_box} -> {:ok, unconditional_move(grid_with_pushed_box, point, target)}
          :error -> :error
        end
    end
  end

  def move(grid, point, instruction) when instruction in ["^", "v"] do
    case Map.get(grid, point) do
      nil ->
        {:ok, grid}

      "#" ->
        :error

      type when type in ["@", "O"] ->
        target = target_point(point, instruction)

        case move(grid, target, instruction) do
          {:ok, updated_grid} -> {:ok, unconditional_move(updated_grid, point, target)}
          :error -> :error
        end

      type when type in ["[", "]"] ->
        {point_a, target_a, point_b, target_b} = double_box_targets(grid, point, instruction)

        with {:ok, grid_with_half_push} <- move(grid, target_a, instruction),
             {:ok, grid_with_full_push} <- move(grid_with_half_push, target_b, instruction) do
          {:ok, grid_with_full_push |> unconditional_move(point_a, target_a) |> unconditional_move(point_b, target_b)}
        end
    end
  end

  defp double_box_targets(grid, {x, y} = point, instruction) do
    {target_x, target_y} = target_point(point, instruction)

    case Map.get(grid, point) do
      "[" -> {{x, y}, {target_x, target_y}, {x + 1, y}, {target_x + 1, target_y}}
      "]" -> {{x - 1, y}, {target_x - 1, target_y}, {x, y}, {target_x, target_y}}
    end
  end

  defp target_point({x, y}, "^"), do: {x, y - 1}
  defp target_point({x, y}, "v"), do: {x, y + 1}
  defp target_point({x, y}, "<"), do: {x - 1, y}
  defp target_point({x, y}, ">"), do: {x + 1, y}

  defp unconditional_move(grid, source, target) do
    source_type = Map.get(grid, source)

    grid
    |> Map.put(target, source_type)
    |> Map.delete(source)
  end

  defp all_moves(grid, location, instructions)

  defp all_moves(grid, _location, []), do: grid

  defp all_moves(grid, location, [head_instruction | tail_instructions]) do
    case move(grid, location, head_instruction) do
      {:ok, updated_grid} -> all_moves(updated_grid, target_point(location, head_instruction), tail_instructions)
      :error -> all_moves(grid, location, tail_instructions)
    end
  end

  def part_b(lines) do
    {grid, instructions, starting_point} = parse_input_b(lines)

    grid
    |> all_moves(starting_point, instructions)
    |> Enum.filter(fn {_location, type} -> type == "[" end)
    |> Enum.map(fn {{x, y}, _type} -> x + 100 * y end)
    |> Enum.sum()
  end

  defp parse_input_b(lines) do
    {grid, instructions, {start_x, start_y}} = parse_input(lines)

    grid_b = to_input_b(grid)
    starting_point = {2 * start_x, start_y}

    {grid_b, instructions, starting_point}
  end

  def to_input_b(version_a) do
    version_a
    |> Enum.flat_map(&to_b/1)
    |> Map.new()
  end

  defp to_b({{x, y}, "#"}), do: [{{2 * x, y}, "#"}, {{2 * x + 1, y}, "#"}]
  defp to_b({{x, y}, "O"}), do: [{{2 * x, y}, "["}, {{2 * x + 1, y}, "]"}]
  defp to_b({{x, y}, "@"}), do: [{{2 * x, y}, "@"}]

  def a() do
    Helpers.file_to_lines!("inputs/day15.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day15.txt")
    |> part_b()
  end
end
