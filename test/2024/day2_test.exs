defmodule AocEx.Year2024.Day2Test do
  use ExUnit.Case
  doctest AocEx

  test "second day" do
    input =
      """
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      8 6 4 4 1
      1 3 6 7 9
      1 3 2 4 5
      66 68 67 68 70
      """

    assert AocEx.Year2024.Day2.first(input) == 2
    assert AocEx.Year2024.Day2.second(input) == 5
  end
end
