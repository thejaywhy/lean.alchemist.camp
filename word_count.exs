# Read in a file, count number of words in it

cli_args =
  IO.gets("""
  File counter 2000:

  Usage: [filename] -[flags]
  -w      display word count (default)
  -l      display line count
  -c      display character count
  Use zero or more options.

  Enter File name:
  """)
  |> String.trim()
  |> String.split("-")

filename = List.first(cli_args) |> String.trim()

IO.inspect(filename)
IO.inspect(cli_args)

options =
  case Enum.at(cli_args, 1) do
    nil ->
      ["w"]

    args ->
      # split everything
      String.split(args, "")
      # remove empty strings
      |> Enum.filter(fn x -> x != "" end)
  end

body = File.read!(filename)

lines =
  String.split(body, "\n")
  |> Enum.count()

# remove non word characters, keep contracttions
words =
  String.split(body, ~r{(\\n|[^\w']|_)+})
  # remove empty words
  |> Enum.filter(fn x -> x != "" end)
  |> Enum.count()

# split on all the things
chars =
  String.split(body, "")
  # remove empty words
  |> Enum.filter(fn x -> x != "" end)
  |> Enum.count()

Enum.each(options, fn opt ->
  case opt do
    "w" -> IO.puts("Words: #{words}")
    "l" -> IO.puts("Lines: #{lines}")
    "c" -> IO.puts("Chars: #{chars}")
    _ -> nil
  end
end)
