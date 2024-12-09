defmodule AocEx.Year2024.Day3Test do
  use ExUnit.Case
  doctest AocEx

  test "third day first part" do
    input =
      """
      xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
      """

    assert AocEx.Year2024.Day3.first(input) == 161
  end

  test "third day second part" do
    input =
      """
      xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
      """

    assert AocEx.Year2024.Day3.second(input) == 48
  end
end
