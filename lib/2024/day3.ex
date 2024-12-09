defmodule AocEx.Year2024.Day3 do
  defmodule Parser do
    import NimbleParsec

    mul =
      ignore(string("mul("))
      |> integer(min: 1, max: 3)
      |> ignore(string(","))
      |> integer(min: 1, max: 3)
      |> ignore(string(")"))

    do_clause = string("do()") |> replace(:do)
    dont_clause = string("don't()") |> replace(:dont)

    defparsec(:instructions, repeat(eventually(mul)))
    defparsec(:advanced, repeat(eventually(choice([mul, do_clause, dont_clause]))))
  end

  def first(input) do
    input
    |> parse_input()
    |> Enum.flat_map(fn program ->
      {:ok, result, _, _, _, _} = Parser.instructions(program)
      result |> Enum.chunk_every(2) |> Enum.map(fn [a, b] -> a * b end)
    end)
    |> Enum.sum()
  end

  def second(input) do
    input
    |> parse_input()
    |> Enum.flat_map(fn program ->
      with {:ok, result, _, _, _, _} = Parser.advanced(program) do
        result
      end
    end)
    |> advanced_calc()
    |> elem(2)
  end

  defp parse_input(input) do
    input |> String.split("\n", trim: true)
  end

  defp advanced_calc(program) do
    Enum.reduce(program, {:do, [], 0}, fn n, {status, args, sum} ->
      case {status, args, n} do
        {_, _, :dont} ->
          {:dont, [], sum}

        {_, _, :do} ->
          {:do, [], sum}

        {:do, [], _} ->
          {:do, [n], sum}

        {:do, [left], _} ->
          {:do, [], sum + left * n}

        {:dont, args, _} ->
          {:dont, args, sum}
      end
    end)
  end
end
