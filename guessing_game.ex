defmodule GuessingGame do
  # guess between a low number and a high number
  #  => guess middle number, tell user
  # if user says "yes" -> game over
  # if user says "higher" -> bigger(low, high)
  # if user says "lower" -> lower(low, high)
  # anything else -> tell user to enter valid response

  def guess(a, b) when a > b, do: guess(b, a)

  def guess(low, high) do
    response =
      IO.gets("Maybe you're thinking of #{mid(low, high)}?\n")
      |> String.trim()

    case response do
      "bigger" ->
        bigger(low, high)

      "smaller" ->
        lower(low, high)

      "bingo" ->
        "I did it!"

      _ ->
        IO.puts("that's not a valid answer. pick 'bigger', 'smaller', or 'bingo'\n")
        guess(low, high)
    end

    IO.puts(response)
  end

  def mid(low, high) do
    div(low + high, 2)
  end

  def bigger(low, high) do
    new_low = min(high, div(low + high, 2) + 1)
    guess(new_low, high)
  end

  def lower(low, high) do
    new_high = max(low, div(low + high, 2) - 1)
    guess(low, new_high)
  end
end
