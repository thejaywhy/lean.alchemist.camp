defmodule ImageMover do
  @moduledoc """
  Finds all files in current working directory that endin in
  `.jpg`, `.gif`, `.bmp` or `.png`
  then moves them to a sub-directory called `images`.

  If the `images` directory does not exist, it will be created.

  This is my solution to alchemist.camp Challenge 3 from
  https://alchemist.camp/episodes/minimal-todo-1
  """

  @doc """
  Entry point to the tool
  """
  def start() do
    create_directory()

    Path.wildcard("*.{jpg,gif,bmp,png}")
    |> move()
  end

  defp create_directory(path \\ "images") do
    img_path = Path.relative_to_cwd(path)

    unless File.dir?(img_path) do
      IO.puts("Creating an '#{path}' directory")
      File.mkdir_p!(img_path)
    end
  end

  defp move(files, path \\ "images") do
    Enum.each(files, fn x ->
      File.rename(x, Path.join(path, x))
      IO.puts("Moved '#{x}' to '#{path}'")
    end)
  end
end
