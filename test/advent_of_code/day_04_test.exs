defmodule AdventOfCode.Day04Test do
  use ExUnit.Case

  import AdventOfCode.Day04

  test "test_password/2 correctly tests a single password" do
    input = 273_456
    result = test_password(input, [], part: :one)
    assert result == []

    result = test_password(233_567, [], part: :one)
    assert result == [233_567]

    result = test_password(123_456, [], part: :one)
    assert result == []

    result = test_password(122_576, [], part: :one)
    assert result == []

    result = test_password(123_455, [], part: :one)
    assert result == [123_455]
  end

  test "test_password/2 tests for additional part 2 requirements" do
    result = test_password(111_122, [], part: :two)
    assert result == [111_122]

    result = test_password(123_444, [], part: :two)
    assert result == []
  end

  test "part1" do
    input = 273_025..767_253
    result = part1(input) |> IO.inspect(label: "Day 4, Part 1")

    assert result == 910
  end

  test "part2" do
    input = 273_025..767_253
    result = part2(input) |> IO.inspect(label: "Day 4, Part 2")

    assert result == 598
  end
end
