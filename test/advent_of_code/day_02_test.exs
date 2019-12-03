defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  def get_inputs() do
    input = File.read!(Path.join(__DIR__, "../../data/day2.txt"))
    Enum.map(String.split(input, ","), &String.to_integer(&1))
  end

  test "sample-01" do
    input = [1, 0, 0, 0, 99]
    result = process(input)
    assert result == [2, 0, 0, 0, 99]
  end

  test "sample-2" do
    input = [2, 3, 0, 3, 99]
    result = process(input)
    assert result == [2, 3, 0, 6, 99]
  end

  test "sample-3" do
    input = [2, 4, 4, 5, 99, 0]
    result = process(input)
    assert result == [2, 4, 4, 5, 99, 9801]
  end

  test "sample-4" do
    input = [1, 1, 1, 4, 99, 5, 6, 0, 99]
    result = process(input)
    assert result == [30, 1, 1, 4, 2, 5, 6, 0, 99]
  end

  test "part1" do
    input = get_inputs() |> List.replace_at(1, 12) |> List.replace_at(2, 2)
    part1(input) |> IO.inspect(label: "Result")
  end

  test "part2" do
    pristine_input = get_inputs()

    nouns = Enum.to_list(0..99)
    verbs = Enum.to_list(0..99)

    [noun, verb] =
      Enum.reduce_while(nouns, pristine_input, fn noun, input ->
        nouned_input = List.replace_at(input, 1, noun)

        case Enum.reduce_while(verbs, nouned_input, fn verb, input ->
               nouned_and_verbed_input = List.replace_at(input, 2, verb)

               #  IO.puts("Trying noun #{noun} and verb #{verb}")

               case process(nouned_and_verbed_input) do
                 [19_690_720, n, v | _] -> {:halt, [n, v]}
                 _ -> {:cont, input}
               end
             end) do
          [n, v] -> {:halt, [n, v]}
          _ -> {:cont, input}
        end
      end)

    IO.puts("Noun: #{Integer.to_string(noun)}")
    IO.puts("Verb: #{Integer.to_string(verb)}")

    result = 100 * noun + verb

    IO.puts("Result: #{Integer.to_string(result)}")
  end
end
