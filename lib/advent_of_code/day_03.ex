defmodule AdventOfCode.Day03 do
  # Part 1 Idea
  # 0. Assume central port is at coords 0,0
  # 1. Process the instructions to generate coordinate pairs at each step.
  #    Result would look like: [[1,2], [3,4], [5,6]]
  # 2. With two such structures, find the intersection. Those are where the wires cross.
  # 3. Determine the manhattan distance between each intersection coord and 0,0
  # 4. Return the shortest such distance
  def part1(wires) do
    intersections = find_intersections({0, 0}, wires)
    # |> IO.inspect(label: "Intersections")

    Enum.map(intersections, fn {x, y} -> {abs(x), abs(y)} end)
    |> Enum.map(fn {x, y} -> x + y end)
    |> Enum.min()
  end

  def part2(wires) do
    [route1, route2] = generate_routes({0, 0}, wires)
    intersections = find_intersections({0, 0}, wires)

    Enum.map(intersections, fn coord ->
      route1_steps =
        Enum.reduce_while(route1, 0, fn step, acc ->
          if step == coord, do: {:halt, acc}, else: {:cont, acc + 1}
        end)

      route2_steps =
        Enum.reduce_while(route2, 0, fn step, acc ->
          if step == coord, do: {:halt, acc}, else: {:cont, acc + 1}
        end)

      route1_steps + route2_steps
    end)
    |> Enum.min()
  end

  def find_intersections(home, wires) do
    [route1, route2] = generate_routes(home, wires)

    # IO.puts("Length of wire1: #{length(route1)} steps")
    # IO.puts("Length of wire2: #{length(route2)} steps")

    route1_set = route1 |> Enum.into(MapSet.new())
    route2_set = route2 |> Enum.into(MapSet.new())

    MapSet.intersection(route1_set, route2_set)
    |> MapSet.delete({0, 0})
    |> Enum.to_list()
  end

  def generate_routes(home, wires) do
    Enum.map(wires, fn wire -> generate_route(home, wire) end)
  end

  def generate_route(home, wire) do
    # IO.puts("Generating route for wire with length #{length(wire)}")

    {route, _} =
      Enum.flat_map_reduce(wire, home, fn ins, {prev_x, prev_y} ->
        # IO.puts(" - processing instruction #{ins}")

        %{"direction" => direction, "distance" => distance} =
          Regex.named_captures(~r/^(?<direction>U|D|L|R)(?<distance>\d+)/, ins)

        distance = String.to_integer(distance)

        steps =
          case direction do
            "U" -> Enum.map((prev_y + 1)..(prev_y + distance), &{prev_x, &1})
            "D" -> Enum.map((prev_y - 1)..(prev_y - distance), &{prev_x, &1})
            "R" -> Enum.map((prev_x + 1)..(prev_x + distance), &{&1, prev_y})
            "L" -> Enum.map((prev_x - 1)..(prev_x - distance), &{&1, prev_y})
          end

        {steps, List.last(steps)}
      end)

    [home | route]
  end
end
