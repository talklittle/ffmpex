defmodule FFprobe do
  @moduledoc """
  Execute `ffprobe` CLI commands.

  > `ffprobe` is a simple multimedia streams analyzer. You can use it to output
  all kinds of information about an input including duration, frame rate, frame size, etc.
  It is also useful for gathering specific information about an input to be used in a script.

  (from https://trac.ffmpeg.org/wiki/FFprobeTips)
  """

  @type format_map :: %{}
  @type streams_list :: [%{}]

  @doc """
  Get the duration in seconds, as a float.

  If no duration (e.g., a still image), returns `:no_duration`.
  If the file does not exist, returns { :error, :no_such_file }
  """
  @spec duration(binary | format_map) :: float | :no_duration | {:error, :no_such_file}
  def duration(file_path) when is_binary(file_path) do
    case format(file_path) do
      {:ok, format} ->
        duration(format)

      {:error, :invalid_file} ->
        duration(%{"duration" => nil})

      error ->
        error
    end
  end

  def duration(format_map) when is_map(format_map) do
    case format_map["duration"] do
      nil -> :no_duration
      result -> Float.parse(result) |> elem(0)
    end
  end

  @doc """
  Get a list of formats for the file.

  If the file does not exist, returns `{:error, :no_such_file}`.
  If the file is a non media file, returns `{:error, :invalid_file}`.
  """
  @spec format_names(binary | format_map) ::
          {:ok, [binary]} | {:error, :invalid_file} | {:error, :no_such_file}
  def format_names(file_path) when is_binary(file_path) do
    case format(file_path) do
      {:ok, format} ->
        format_names(format)

      error ->
        error
    end
  end

  def format_names(format_map) when is_map(format_map) do
    {:ok, String.split(format_map["format_name"], ",")}
  end

  @doc """
  Get the "format" map, containing general info for the specified file,
  such as number of streams, duration, file size, and more.

  If the file does not exist, returns `{:error, :no_such_file}`.
  If the file is a non media file, returns `{:error, :invalid_file}`.
  """
  @spec format(binary) :: {:ok, format_map} | {:error, :invalid_file} | {:error, :no_such_file}
  def format(file_path) do
    cmd_args = ["-print_format", "json", "-show_format", file_path]

    case Rambo.run(ffprobe_path(), cmd_args, log: false) do
      {:ok, %{out: result}} ->
        format =
          result
          |> Jason.decode!()
          |> Map.get("format", %{})

        {:ok, format}

      {:error, %{err: result}} ->
        file_error(file_path, result)
    end
  end

  @doc """
  Get a list a of streams from the file.

  If the file does not exist, returns `{:error, :no_such_file}`.
  If the file is a non media file, returns `{:error, :invalid_file}`.
  """
  @spec streams(binary) :: {:ok, streams_list} | {:error, :invalid_file} | {:error, :no_such_file}
  def streams(file_path) do
    cmd_args = ["-print_format", "json", "-show_streams", file_path]

    case Rambo.run(ffprobe_path(), cmd_args, log: false) do
      {:ok, %{out: result}} ->
        streams =
          result
          |> Jason.decode!()
          |> Map.get("streams", [])

        {:ok, streams}

      {:error, %{err: result}} ->
        file_error(file_path, result)
    end
  end

  defp file_error(file_path, error_text) do
    cond do
      File.exists?(file_path) -> {:error, :invalid_file}
      String.contains?(error_text, "Invalid data found when processing input") -> {:error, :invalid_file}
      String.contains?(error_text, "404 Not Found") -> {:error, :no_such_file}
      true -> {:error, :no_such_file}
    end
  end

  # Read ffprobe path from config. If unspecified, check if `ffprobe` is in env $PATH.
  # If it is not, then raise a error.
  defp ffprobe_path do
    case Application.get_env(:ffmpex, :ffprobe_path, nil) do
      nil ->
        case System.find_executable("ffprobe") do
          nil ->
            raise "FFmpeg not installed"

          path ->
            path
        end

      path ->
        path
    end
  end
end
