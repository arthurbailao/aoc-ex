defmodule AocEx.Year2024.Day4 do
  def first(input) do
    grid = parse_input(input)

    for {pos, _} <- grid, dir <- directions() do
      case search(grid, ~c"XMAS", pos, dir) do
        :found -> 1
        :halt -> 0
      end
    end
    |> Enum.sum()
  end

  def second(input) do
    grid = parse_input(input)

    for {pos, _} <- grid, dir <- diagonals() do
      if match_mas?(grid, pos, dir) and match_mas?(grid, pos, rotate90(dir)), do: 1, else: 0
    end
    |> Enum.sum()
  end

  defp search(grid, [c | rest], position, direction) do
    case Map.get(grid, position) do
      ^c -> search(grid, rest, walk(position, direction), direction)
      _ -> :halt
    end
  end

  defp search(_, [], _, _), do: :found

  defp match_mas?(grid, position, direction) do
    with ?M <- Map.get(grid, position |> walk(direction)),
         ?A <- Map.get(grid, position),
         ?S <- Map.get(grid, position |> walk(direction |> rotate180())) do
      true
    else
      _ -> false
    end
  end

  defp walk({row, col}, {x, y}) do
    {row + x, col + y}
  end

  defp rotate90({a, b}), do: {b, -a}

  defp rotate180({a, b}), do: {-a, -b}

  defp directions() do
    [
      {-1, -1},
      {-1, 0},
      {-1, 1},
      {0, -1},
      {0, 1},
      {1, -1},
      {1, 0},
      {1, 1}
    ]
  end

  defp diagonals() do
    directions()
    |> Enum.filter(fn {x, y} -> x != 0 and y != 0 end)
  end

  defp parse_input(input) do
    for {line, row} <- String.split(input, "\n", trim: true) |> Enum.with_index(),
        {c, col} <- String.to_charlist(line) |> Enum.with_index(),
        into: %{} do
      {{row, col}, c}
    end
  end
end
