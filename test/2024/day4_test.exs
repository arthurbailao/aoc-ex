defmodule AocEx.Year2024.Day4Test do
  use ExUnit.Case
  doctest AocEx

  test "fourth day" do
    input =
      """
      MMMSXXMASM
      MSAMXMSMSA
      AMXSXMAAMM
      MSAMASMSMX
      XMASAMXAMM
      XXAMMXXAMA
      SMSMSASXSS
      SAXAMASAAA
      MAMMMXMMMM
      MXMXAXMASX
      """

    assert AocEx.Year2024.Day4.first(input) == 18
    assert AocEx.Year2024.Day4.second(input) == 9
  end
end
