defmodule FFmpex do
  @moduledoc """
  Create and execute ffmpeg CLI commands.

  The API is a builder, building up the list of options
  per-file, per-stream(-per-file), and globally.

  Note that adding options is backwards from using
  the ffmpeg CLI; when using ffmpeg CLI, you specify the options
  before each file.
  But with FFmpex (this library), you add the file/stream first, then
  add the relevant options afterward.

  Example usage:

      alias FFmpex.StreamSpecifier

      import FFmpex
      import FFmpex.Options.Main
      import FFmpex.Options.Video.Libx264

      command =
        FFmpex.new_command
        |> add_global_option(option_y)
        |> add_input_file("/path/to/input.avi")
        |> add_output_file("/path/to/output.avi")
          |> add_stream_specifier(%StreamSpecifier{stream_type: :video})
            |> add_stream_option(option_b("64k"))
          |> add_file_option(option_maxrate("256k"))
          |> add_file_option(option_bufsize("64k"))

      system_cmd_result = execute(command)
      {_, 0} = system_cmd_result
  """
  alias FFmpex.Command
  alias FFmpex.File
  alias FFmpex.Option
  alias FFmpex.StreamSpecifier

  @doc """
  Begin a new blank (no options) ffmpeg command.
  """
  def new_command, do: %Command{}

  @doc """
  Add an input file to the command.
  """
  def add_input_file(%Command{files: files} = command, %File{} = file) do
    file = %File{file | type: :input}
    %Command{command | files: [file | files]}
  end

  def add_input_file(%Command{files: files} = command, file_path) when is_binary(file_path) do
    file = %File{type: :input, path: file_path}
    %Command{command | files: [file | files]}
  end

  @doc """
  Add an output file to the command.
  """
  def add_output_file(%Command{files: files} = command, %File{} = file) do
    file = %File{file | type: :output}
    %Command{command | files: [file | files]}
  end

  def add_output_file(%Command{files: files} = command, file_path) when is_binary(file_path) do
    file = %File{type: :output, path: file_path}
    %Command{command | files: [file | files]}
  end

  @doc """
  Add a stream specifier to the most recent file.
  The stream specifier is used as a target for per-stream options.
  """
  def add_stream_specifier(%Command{files: [file | files]} = command, %StreamSpecifier{} = stream_specifier) do
    file = %File{file | stream_specifiers: [stream_specifier | file.stream_specifiers]}
    %Command{command | files: [file | files]}
  end

  @doc """
  Add a global option that applies to the entire command.
  """
  def add_global_option(%Command{global_options: options} = command, %Option{} = option) do
    %Command{command | global_options: [option | options]}
  end

  @doc """
  Add a per-file option to the command.
  Applies to the most recently added file.
  """
  def add_file_option(%Command{files: [file | files]} = command, %Option{} = option) do
    file = %File{file | options: [option | file.options]}
    %Command{command | files: [file | files]}
  end

  @doc """
  Add a per-stream option to the command.
  Applies to the most recently added stream specifier, of the most recently added file.
  """
  def add_stream_option(%Command{files: [file | files]} = command, %Option{} = option) do
    %File{stream_specifiers: [stream_specifier | stream_specifiers]} = file
    stream_specifier = %StreamSpecifier{stream_specifier | options: [option | stream_specifier.options]}
    file = %File{file | stream_specifiers: [stream_specifier | stream_specifiers]}
    %Command{command | files: [file | files]}
  end

  @doc """
  Execute the command using ffmpeg CLI.
  """
  def execute(%Command{files: files, global_options: options}) do
    options = Enum.map(options, &arg_for_option/1)
    cmd_args = List.flatten([options, options_list(files)])
    System.cmd ffmpeg_path(), cmd_args, stderr_to_stdout: true
  end

  defp options_list(files) do
    input_files = Enum.filter(files, fn %File{type: type} -> type == :input end)
    output_files = Enum.filter(files, fn %File{type: type} -> type == :output end)
    options_list(input_files, output_files)
  end

  defp options_list(input_files, output_files, acc \\ [])
  defp options_list([], [], acc), do: List.flatten(acc)
  defp options_list(input_files, [output_file | output_files], acc) do
    acc = [File.command_arguments(output_file), output_file.path | acc]
    options_list(input_files, output_files, acc)
  end
  defp options_list([input_file | input_files], [], acc) do
    acc = [File.command_arguments(input_file), "-i", input_file.path | acc]
    options_list(input_files, [], acc)
  end

  defp arg_for_option(%Option{name: name, require_arg: false, argument: nil}) do
    ~w(#{name})
  end
  defp arg_for_option(%Option{name: name, argument: arg}) when not is_nil(arg) do
    ~w(#{name} #{arg})
  end

  # Read ffmpeg path from config. If unspecified, assume `ffmpeg` is in env $PATH.
  defp ffmpeg_path do
    Application.get_env(:ffmpex, :ffmpeg_path, "ffmpeg")
  end
end
