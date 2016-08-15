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
  """
  def duration(file_path) do
    cmd_args = ~w(-v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 #{file_path})
    {result, 0} = System.cmd ffprobe_path(), cmd_args, stderr_to_stdout: true
    case String.trim(result) do
      "N/A" -> :no_duration
      result ->
        {result_float, _} = Float.parse(result)
        result_float
    end
  end

  # Read ffprobe path from config. If unspecified, assume `ffprobe` is in env $PATH.
  defp ffprobe_path do
    Application.get_env(:ffmpex, :ffprobe_path, "ffprobe")
  end
end