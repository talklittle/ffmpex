defmodule FFprobe do
  @moduledoc """
  Execute ffprobe CLI commands.

  > `ffprobe` is a simple multimedia streams analyzer. You can use it to output
  all kinds of information about an input including duration, frame rate, frame size, etc.
  It is also useful for gathering specific information about an input to be used in a script.

  (from https://trac.ffmpeg.org/wiki/FFprobeTips)
  """

  @doc """
  Get the duration in seconds, as a float.
  If no duration (e.g., a still image), returns `:no_duration`
  """
  @spec duration(binary | %{binary => binary}) :: float | :no_duration
  def duration(file_path) when is_binary(file_path) do
    duration(format(file_path))
  end
  def duration(format_map) when is_map(format_map) do
    case format_map["duration"] do
      "N/A" -> :no_duration
      result -> Float.parse(result) |> elem(0)
    end
  end

  @doc """
  Get the "format" map, containing codec info for the specified file.
  """
  @spec format(binary) :: %{binary => binary}
  def format(file_path) do
    cmd_args = ~w(-show_format #{file_path})
    {result, 0} = System.cmd ffprobe_path(), cmd_args, stderr_to_stdout: true

    ~r/^([^=]+)=(.+)$/m
    |> Regex.scan(result)
    |> Enum.map(fn [_line, key, value] -> {key, value} end)
    |> Enum.into(%{})
  end

  # Read ffprobe path from config. If unspecified, assume `ffprobe` is in env $PATH.
  defp ffprobe_path do
    Application.get_env(:ffmpex, :ffprobe_path, "ffprobe")
  end
end