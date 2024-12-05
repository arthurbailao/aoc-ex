defmodule AocEx.Year2024.Day1Test do
  use ExUnit.Case
  doctest AocEx

  test "first day" do
    input =
      """
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
      """

    assert AocEx.Year2024.Day1.first(input) == 11
    assert AocEx.Year2024.Day1.second(input) == 31
  end
end
