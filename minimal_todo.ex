defmodule MinimalTodo do
  @moduledoc """
  MinimalTodo presents a simple CLI based TODO management
  system. 

  Built as part of https://alchemist.camp/episodes/minimal-todo-1
  """

  @doc """
  Start the TODO CLI
  """
  def start do
    # ask user for a filename to read in
    filename =
      IO.gets("Name of .csv to load: ")
      |> String.trim()

    # ask user for a filename to read in
    # open file and read contents
    read(filename)
    # parse the data
    |> parse()
    |> get_command()

    # ask user for command
    #   - read todos, add todo, delete todo, load file, save file
  end

  @doc """
  Ask user for input, and then perform that action
  """
  def get_command(data) do
    prompt = """
    Type the first letter of the command you want to run\n
        (R)ead Todos
        (A)dd a Todo
        (D)elete a Todo
        (L)oad a .csv
        (S)ave a .csv
        (Q)uit
    """

    command =
      IO.gets(prompt)
      |> String.trim()
      |> String.downcase()

    case command do
      "r" -> show_todos(data)
      "d" -> delete_todo(data)
      "q" -> "Goodbye :)"
      "_" -> get_command(data)
    end
  end

  @doc """
  Delete TODO from memory
  """
  defp delete_todo(data) do
    todo =
      IO.gets("Which todo would you like to delete?\n")
      |> String.trim()

    if Map.has_key?(data, todo) do
      IO.puts("ok")
      new_data = Map.drop(data, [todo])
      IO.puts("deleted #{todo}")
      get_command(new_data)
    else
      IO.puts("'#{todo}' does not exists")
      show_todos(data, false)
      delete_todo(data)
    end
  end

  @doc """
  Read contents of `filename` into memory.
  Assumes it's a csv file
  """
  defp read(filename) do
    case File.read(filename) do
      {:ok, body} ->
        body

      {:error, reason} ->
        IO.puts("Could not open #{filename}: #{:file.format_error(reason)}\n")
        start()
    end
  end

  @doc """
  Parse the contents of a TODO file and save as a map
  """
  defp parse(body) do
    # split the body on new lines
    # header will be first item in list
    # all other lines are todo items
    [header | items] = String.split(body, ~r{(\r\n|\n|\r)})

    # now we need to split on commas
    titles = tl(String.split(header, ","))

    # make a map 
    parse_lines(items, titles)
  end

  @doc """
  Expects a list of `lines` and uses a list of `titles` to
  build a map of TODOs where each `key` is the name of the 
  TODO and the `value` is the contents of the TODO item
  """
  defp parse_lines(lines, titles) do
    Enum.reduce(lines, %{}, fn line, built ->
      [name | fields] = String.split(line, ",")

      if Enum.count(fields) == Enum.count(titles) do
        line_data =
          Enum.zip(titles, fields)
          |> Enum.into(%{})

        Map.merge(built, %{name => line_data})
      else
        built
      end
    end)
  end

  @doc """
  List the names of each TODO item that is currently held
  in memory
  """
  def show_todos(data, next_command? \\ true) do
    items = Map.keys(data)
    IO.puts("You have the following todos:\n")
    Enum.each(items, fn item -> IO.puts(item) end)
    IO.puts("\n")

    if next_command? do
      get_command(data)
    end
  end
end
