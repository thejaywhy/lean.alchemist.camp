defmodule NameGreeter do
  # - Ask for a name
  # - Take in a name
  # - Say hello to name
  # - If name matches "jaywhy", give a special greeting 

  def greeting() do
    name =
      IO.gets("What's your name?\n")
      |> String.trim()

    case name do
      "jaywhy" -> "Hey now! That's my FAVORITE name!"
      _ -> "Greetings #{name}, nice to meet you!"
    end
  end
end
