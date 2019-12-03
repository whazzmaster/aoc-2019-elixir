defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  def get_inputs() do
    input = File.read!(Path.join(__DIR__, "../../data/day1.txt"))
    Enum.map(String.split(input, "\n"), &String.to_integer(&1))
  end

  test "part1" do
    module_weights = get_inputs()
    result = part1(module_weights)
    # |> IO.inspect(label: "Day 1, Part 1")

    # accepted
    assert result == 3_454_026
  end

  test "part2" do
    module_weights = get_inputs()

    result = part2(module_weights)
    # |> IO.inspect(label: "Day 1, Part 2")

    # accepted
    assert result == 5_178_170
  end
end
