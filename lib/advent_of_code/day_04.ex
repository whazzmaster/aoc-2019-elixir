defmodule AdventOfCode.Day04 do
  def part1(range) do
    Enum.reduce(range, [], &test_password(&1, &2, part: :one))
    |> length
  end

  def part2(range) do
    Enum.reduce(range, [], &test_password(&1, &2, part: :two))
    |> length
  end

  def test_password(pw, compliant_passwords, part: part) do
    initial = %{prev: nil, valid: false}

    result =
      Enum.reduce_while(Integer.digits(pw), initial, fn digit, acc ->
        # IO.inspect(digit, label: "Processing digit")
        # IO.inspect(acc, label: "Current acc")

        case acc[:prev] do
          nil ->
            {:cont, %{prev: digit, dupes: %{}, halted: false}}

          _ ->
            cond do
              # If the digit is greater than the previous one we can move on
              acc[:prev] < digit ->
                # IO.inspect("detected greater than")
                updated = Map.merge(acc, %{prev: digit})
                {:cont, updated}

              # If the digit is less than the previous one then halt immediately
              acc[:prev] > digit ->
                # IO.inspect("detected less than, BAILING*********")
                updated = Map.merge(acc, %{halted: true})
                {:halt, updated}

              # If the digit matches the previous one then update our dupes
              # hash for later validation, depending on the conditions
              acc[:prev] == digit ->
                # IO.inspect("detected equals")
                %{dupes: dupes} = acc

                updated_dupes =
                  if Map.has_key?(dupes, digit) do
                    Map.merge(dupes, %{digit => dupes[digit] + 1})
                  else
                    Map.merge(dupes, %{digit => 2})
                  end

                updated = Map.merge(acc, %{prev: digit, dupes: updated_dupes})
                {:cont, updated}
            end
        end
      end)

    # |> IO.inspect(label: "Result")

    %{dupes: dupes} = result

    # If we didn't halt and our dupes collection satisfies the current ruleset,
    # then add the pw to the list of potential passwords
    if !result[:halted] && satisfies_dupe_check(dupes, part) do
      [pw | compliant_passwords]
    else
      compliant_passwords
    end
  end

  def satisfies_dupe_check(dupes, :one) do
    length(Map.keys(dupes)) > 0
  end

  def satisfies_dupe_check(dupes, :two) do
    Enum.reduce_while(dupes, false, fn {_, occurrences}, _ ->
      if occurrences == 2, do: {:halt, true}, else: {:cont, false}
    end)
  end
end
