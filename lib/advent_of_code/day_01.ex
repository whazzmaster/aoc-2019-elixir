defmodule AdventOfCode.Day01 do
  def part1(module_weights) do
    Enum.reduce(module_weights, 0, &calc_fuel/2)
  end

  def part2(module_weights) do
    Enum.reduce(module_weights, 0, fn x, acc ->
      calc_fuel_recursively(x) + acc
    end)
  end

  defp calc_fuel_recursively(module_weight) do
    additional_fuel_weight = calc(module_weight)

    if(additional_fuel_weight <= 0) do
      0
    else
      additional_fuel_weight + calc_fuel_recursively(additional_fuel_weight)
    end
  end

  defp calc_fuel(module_weight, total_weight) do
    calc(module_weight) + total_weight
  end

  defp calc(amount) do
    Integer.floor_div(amount, 3) - 2
  end
end
