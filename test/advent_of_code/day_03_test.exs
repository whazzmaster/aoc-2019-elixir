defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Day03

  def get_inputs() do
    input = File.read!(Path.join(__DIR__, "../../data/day3.txt"))
    lines = String.split(input, "\n")
    Enum.map(lines, fn line -> String.split(line, ",") end)
  end

  test "generate_route/2 generates a route of coords" do
    home = {0, 0}
    wire = ["R8", "U5", "L5", "D3"]

    route = generate_route(home, wire)

    assert route == [
             {0, 0},
             {1, 0},
             {2, 0},
             {3, 0},
             {4, 0},
             {5, 0},
             {6, 0},
             {7, 0},
             {8, 0},
             {8, 1},
             {8, 2},
             {8, 3},
             {8, 4},
             {8, 5},
             {7, 5},
             {6, 5},
             {5, 5},
             {4, 5},
             {3, 5},
             {3, 4},
             {3, 3},
             {3, 2}
           ]
  end

  test "find_intersections/2 finds intersecting points" do
    home = {0, 0}
    wires = [["R8", "U5", "L5", "D3"], ["U7", "R6", "D4", "L4"]]
    intersections = find_intersections(home, wires)

    assert intersections == [{3, 3}, {6, 5}]
  end

  test "part1" do
    input = get_inputs()
    result = part1(input) |> IO.inspect(label: "Day 3, Part 1")

    assert result
  end

  test "part2" do
    input = get_inputs()
    result = part2(input) |> IO.inspect(label: "Day 3, Part 2")

    assert result
  end
end
