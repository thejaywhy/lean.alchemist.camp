defmodule ImageMover do
  @image_dir_name "images"

  @moduledoc """
  Finds all files in current working directory that endin in
  `.jpg`, `.gif`, `.bmp` or `.png`
  then moves them to a sub-directory called `#{@image_dir_name}`.

  If the `#{@image_dir_name}` directory does not exist, it will be created.

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

  @doc """
  If the given `path` does not exist, create it
  """
  def create_directory(path \\ @image_dir_name) do
    img_path = Path.relative_to_cwd(path)

    unless File.dir?(img_path) do
      case File.mkdir_p(img_path) do
        {:ok} -> IO.puts("Created an '#{path}' directory")
        {:error} -> IO.puts("Could not create '#{path}'' directory")
      end
    end
  end

  @doc """
  Move each item in the `files` list into the given
  `path`.

  `path` defaults to '#{@image_dir_name}'
  """
  def move(files, path \\ @image_dir_name) do
    Enum.each(files, fn x ->
      case File.rename(x, Path.join(path, x)) do
        :ok -> IO.puts("Moved '#{x}' to '#{path}'")
        {:error, _} -> IO.puts("Error moving '#{x}' to '#{path}'")
      end
    end)
  end
end
