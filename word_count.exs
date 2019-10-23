# Read in a file, count number of words in it

filename =
  IO.gets("File to count: ")
  |> String.trim()

body = File.read!(filename)

option =
  IO.gets("Do you want to count words, lines, or characters? ")
  |> String.trim()

case option do
  "lines" ->
    String.split(body, "\n")
    |> Enum.count()
    |> IO.puts()

  "characters" ->
    # remove non word characters, keep contracttions
    String.split(body, "")
    # remove empty words
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.count()
    |> IO.puts()

  _ ->
    # remove non word characters, keep contracttions
    String.split(body, ~r{(\\n|[^\w']|_)+})
    # remove empty words
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.count()
    |> IO.puts()
end
