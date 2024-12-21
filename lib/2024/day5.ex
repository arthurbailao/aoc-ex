defmodule AocEx.Year2024.Day5 do
  def first(input) do
    {rules, updates} = parse_input(input)

    updates
    |> Enum.filter(fn {update, _, _} ->
      Enum.all?(update, fn {n, i} ->
        case Map.get(rules, n) do
          nil -> true
          lower_than -> Enum.all?(lower_than, &(update[&1] > i))
        end
      end)
    end)
    |> Enum.reduce(0, fn {_, _, i}, acc -> acc + i end)
  end

  def second(input) do
    {rules, updates} = parse_input(input)

    updates
    |> Enum.filter(fn {update, _, _} ->
      !Enum.all?(update, fn {n, i} ->
        case Map.get(rules, n) do
          nil -> true
          lower_than -> Enum.all?(lower_than, &(update[&1] > i))
        end
      end)
    end)
    |> Enum.map(fn {_, pages, _} ->
      Enum.sort(pages, fn {a, _}, {b, _} ->
        case Map.get(rules, b) do
          nil -> true
          lower_than -> !Enum.member?(lower_than, a)
        end
      end)
    end)
    |> Enum.map(fn page ->
      middle = page |> length() |> div(2)
      page |> Enum.at(middle) |> elem(0)
    end)
    |> Enum.sum()
  end

  defp parse_input(input) do
    [head, tail] = String.split(input, "\n\n", trim: true)

    rules =
      for line <- String.split(head, "\n", trim: true), reduce: %{} do
        acc ->
          [left, right] = String.split(line, "|")

          Map.update(
            acc,
            String.to_integer(left),
            [String.to_integer(right)],
            &[String.to_integer(right) | &1]
          )
      end

    updates =
      tail
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        pages =
          line
          |> String.split(",")
          |> Enum.map(&String.to_integer/1)
          |> Enum.with_index()

        middle = pages |> length() |> div(2)
        {Map.new(pages), pages, Enum.at(pages, middle) |> elem(0)}
      end)

    {rules, updates}
  end
end
