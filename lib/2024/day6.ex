defmodule AocEx.Year2024.Day6 do
  def first(input) do
    {grid, start} = parse_input(input)
    {:ok, visited} = visit(grid, %{}, start, {-1, 0})
    Enum.count(visited)
  end

  def second(input) do
    {grid, start} = parse_input(input)

    {:ok, obstructions} = visit_and_count_loops(grid, {%{}, MapSet.new()}, start, {-1, 0})
    obstructions |> MapSet.size()
  end

  defp visit(grid, visited, position, direction) do
    case {Map.get(grid, position), Map.get(visited, position)} do
      {?., ^direction} ->
        {:loop, visited}

      {?., _} ->
        visit(grid, Map.put(visited, position, direction), walk(position, direction), direction)

      {?#, _} ->
        turn = direction |> rotate90()
        last_position = position |> back(direction)
        visit(grid, visited, walk(last_position, turn), turn)

      {nil, _} ->
        {:ok, visited}
    end
  end

  defp visit_and_count_loops(grid, {visited, obstructions}, position, direction) do
    case Map.get(grid, position) do
      ?. ->
        obstruction = walk(position, direction)

        obs =
          if Map.get(grid, obstruction) == ?. do
            case visit(Map.put(grid, obstruction, ?#), visited, position, direction) do
              {:ok, _} ->
                obstructions

              {:loop, _} ->
                MapSet.put(obstructions, obstruction)
            end
          else
            obstructions
          end

        visit_and_count_loops(
          grid,
          {Map.put(visited, position, direction), obs},
          walk(position, direction),
          direction
        )

      ?# ->
        turn = direction |> rotate90()
        last_position = position |> back(direction)
        visit_and_count_loops(grid, {visited, obstructions}, walk(last_position, turn), turn)

      nil ->
        {:ok, obstructions}
    end
  end

  defp parse_input(input) do
    grid =
      for {line, row} <- String.split(input, "\n", trim: true) |> Enum.with_index(),
          {c, col} <- String.to_charlist(line) |> Enum.with_index(),
          into: %{} do
        {{row, col}, c}
      end

    {start, _} = grid |> Enum.find(fn {_, c} -> c == ?^ end)

    {grid |> Map.put(start, ?.), start}
  end

  defp walk({row, col}, {x, y}) do
    {row + x, col + y}
  end

  defp back({row, col}, {x, y}) do
    {row - x, col - y}
  end

  defp rotate90({a, b}), do: {b, -a}
end
