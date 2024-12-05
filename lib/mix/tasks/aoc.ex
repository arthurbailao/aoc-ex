defmodule Mix.Tasks.Aoc do
  @moduledoc "Entrypoint for Advent of Code solutions"
  @shortdoc "Solves Advent of Code"

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    {parsed, _, _} =
      OptionParser.parse(args, strict: [year: :integer, day: :integer, file: :string])

    with {:ok, year} <- Keyword.fetch(parsed, :year),
         {:ok, day} <- Keyword.fetch(parsed, :day),
         {:ok, file} <- Keyword.fetch(parsed, :file) do
      day_module = "Elixir.AocEx.Year#{year}.Day#{day}" |> String.to_existing_atom()
      input = File.read!(file)

      apply(day_module, :first, [input]) |> IO.puts()
      apply(day_module, :second, [input]) |> IO.puts()
    else
      :error ->
        IO.puts("Usage: mix aoc --year <year> --day <day> --file <file>")
        exit({:shutdown, 126})
    end
  end
end
