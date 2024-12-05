defmodule AocEx.Year2024.Day1 do
  require Integer

  def first(input) do
    {left, right} = parse_input(input)

    Enum.zip(Enum.sort(left), Enum.sort(right))
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def second(input) do
    {left, right} = parse_input(input)

    freq = Enum.frequencies(right)

    left
    |> Enum.map(fn n -> n * (freq[n] || 0) end)
    |> Enum.sum()
  end

  defp parse_input(input) do
    {left, right} =
      input
      |> String.split("\n", trim: true)
      |> Enum.flat_map(&String.split(&1, " ", trim: true))
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.split_with(fn {_, i} -> Integer.is_even(i) end)

    {left |> Enum.map(&elem(&1, 0)), right |> Enum.map(&elem(&1, 0))}
  end
end
