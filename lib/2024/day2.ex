defmodule AocEx.Year2024.Day2 do
  require Integer

  def first(input) do
    for report <- parse_input(input),
        chunks = Enum.chunk_every(report, 2, 1, :discard) do
      Enum.all?(chunks, fn [a, b] -> a < b && b - a <= 3 end) ||
        Enum.all?(chunks, fn [a, b] -> b < a && a - b <= 3 end)
    end
    |> Enum.count(& &1)
  end

  def second(input) do
    for report <- parse_input(input) do
      [report, Enum.map(report, &(&1 * -1))]
      |> Enum.map(fn r ->
        case Enum.reduce_while(r, {:safe, :start}, &reducer/2) do
          {:safe, _} -> true
          {:almost_unsafe, _} -> true
          :unsafe -> false
        end
      end)
      |> Enum.any?()
    end
    |> Enum.count(& &1)
  end

  defp reducer(level, {:safe, :start}), do: {:cont, {:safe, level}}

  defp reducer(level, {status, last_level}) do
    case {status, (level - last_level) in 1..3} do
      {:safe, true} ->
        {:cont, {:safe, level}}

      {:safe, false} ->
        {:cont, {:almost_unsafe, min(level, last_level)}}

      {:almost_unsafe, true} ->
        {:cont, {:almost_unsafe, level}}

      {:almost_unsafe, false} ->
        {:halt, :unsafe}
    end
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
