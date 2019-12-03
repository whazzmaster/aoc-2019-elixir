defmodule AdventOfCode.Day02 do
  def part1(args) do
    process(args)
  end

  def part2(args) do
  end

  def process(input) do
    instructions = Enum.chunk_every(input, 4, 4, [])
    ins_idxs = Range.new(0, length(instructions) - 1) |> Enum.map(&(4 * &1))

    Enum.reduce_while(ins_idxs, input, fn ins_idx, acc ->
      ins = Enum.slice(acc, ins_idx, 4)
      process_instruction(hd(ins), ins, acc)
    end)
  end

  def process_instruction(1, ins, acc) do
    [_, op_idx_1, op_idx_2, result_idx] = ins
    op_1 = Enum.slice(acc, op_idx_1, 1) |> hd
    op_2 = Enum.slice(acc, op_idx_2, 1) |> hd
    result = op_1 + op_2
    {:cont, List.replace_at(acc, result_idx, result)}
  end

  def process_instruction(2, ins, acc) do
    [_, op_idx_1, op_idx_2, result_idx] = ins
    op_1 = Enum.slice(acc, op_idx_1, 1) |> hd
    op_2 = Enum.slice(acc, op_idx_2, 1) |> hd
    result = op_1 * op_2
    {:cont, List.replace_at(acc, result_idx, result)}
  end

  def process_instruction(99, _, acc), do: {:halt, acc}
end
