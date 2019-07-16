defmodule FFprobe do
  @moduledoc """
  Execute ffprobe CLI commands.

  > `ffprobe` is a simple multimedia streams analyzer. You can use it to output
  all kinds of information about an input including duration, frame rate, frame size, etc.
  It is also useful for gathering specific information about an input to be used in a script.

  (from https://trac.ffmpeg.org/wiki/FFprobeTips)
  """

  @type format_map :: Map.t()
  @type streams_list :: [Map.t()]

  @doc """
  Get the duration in seconds, as a float.
  If no duration (e.g., a still image), returns `:no_duration`
  """
  @spec duration(binary | format_map) :: float | :no_duration
  def duration(file_path) when is_binary(file_path) do
    duration(format(file_path))
  end

  def duration(format_map) when is_map(format_map) do
    case format_map["duration"] do
      nil -> :no_duration
      result -> Float.parse(result) |> elem(0)
    end
  end

  @doc """
  Get a list of formats for the file.
  """
  @spec format_names(binary | format_map) :: [binary]
  def format_names(file_path) when is_binary(file_path) do
    format_names(format(file_path))
  end

  def format_names(format_map) when is_map(format_map) do
    String.split(format_map["format_name"], ",")
  end

  @doc """
  Get the "format" map, containing general info for the specified file,
  such as number of streams, duration, file size, and more.
  """
  @spec format(binary) :: format_map | no_return
  def format(file_path) do
    cmd_args = ["-v", "quiet", "-print_format", "json", "-show_format", file_path]
    {result, 0} = System.cmd(ffprobe_path(), cmd_args, stderr_to_stdout: true)

    result
    |> Jason.decode!()
    |> Map.get("format", %{})
  end

  @spec streams(binary) :: streams_list | no_return
  def streams(file_path) do
    cmd_args = ["-v", "quiet", "-print_format", "json", "-show_streams", file_path]
    {result, 0} = System.cmd(ffprobe_path(), cmd_args, stderr_to_stdout: true)

    result
    |> Jason.decode!()
    |> Map.get("streams", [])
  end

  # Read ffprobe path from config. If unspecified, assume `ffprobe` is in env $PATH.
  defp ffprobe_path do
    case Application.get_env(:ffmpex, :ffprobe_path, nil) do
      nil -> System.find_executable("ffprobe")
      path -> path
    end
  end
end
