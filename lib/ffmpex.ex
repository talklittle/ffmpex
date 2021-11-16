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

  ## Example

      import FFmpex
      use FFmpex.Options

      command =
        FFmpex.new_command
        |> add_global_option(option_y())
        |> add_input_file("/path/to/input.avi")
        |> add_output_file("/path/to/output.avi")
          |> add_stream_specifier(stream_type: :video)
            |> add_stream_option(option_b("64k"))
          |> add_file_option(option_maxrate("128k"))
          |> add_file_option(option_bufsize("64k"))

      :ok = execute(command)
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
  Outputs to stdout, so it can be used directly from `execute/1`'s output

  ##### this option cannot be used with output files
  """
  def to_stdout(%Command{files: files} = command) do
    file = %File{type: :output, path: "-"}
    %Command{command | files: [file | files]}
  end

  @doc """
  Add a stream specifier to the most recent file.
  The stream specifier is used as a target for per-stream options.

  ## Example

      add_stream_specifier(command, stream_type: :video)

  ## Options

  * `:stream_index` - 0-based integer index for the stream
  * `:stream_type` - One of `:video`, `:video_without_pics`, `:audio`, `:subtitle`, `:data`, `:attachments`
  * `:program_id` - ID for the program
  * `:stream_id` - Stream id (e.g. PID in MPEG-TS container)
  * `:metadata_key` - Match streams with the given metadata tag
  * `:metadata_value` - Match streams with the given metadata value. Must also specify `:metadata_key`.
  * `:usable` - Matches streams with usable configuration, the codec must be defined and the essential information such as video dimension or audio sample rate must be present.
  """
  @spec add_stream_specifier(command :: Command.t, opts :: Keyword.t) :: Command.t
  def add_stream_specifier(%Command{files: [file | files]} = command, opts) do
    stream_specifier = struct(StreamSpecifier, opts)
    file = %File{file | stream_specifiers: [stream_specifier | file.stream_specifiers]}
    %Command{command | files: [file | files]}
  end

  @doc """
  Add a global option that applies to the entire command.
  """
  def add_global_option(%Command{global_options: options} = command, %Option{contexts: contexts} = option) do
    validate_contexts!(contexts, :global)
    %Command{command | global_options: [option | options]}
  end

  @doc """
  Add a per-file option to the command.

  Applies to the most recently added file.
  """
  def add_file_option(%Command{files: [file | files]} = command, %Option{contexts: contexts} = option) do
    %{type: file_io_type} = file
    validate_contexts!(contexts, file_io_type)

    file = %File{file | options: [option | file.options]}
    %Command{command | files: [file | files]}
  end

  @doc """
  Add a per-stream option to the command.

  Applies to the most recently added stream specifier, of the most recently added file.
  """
  def add_stream_option(%Command{files: [file | files]} = command, %Option{contexts: contexts} = option) do
    %{type: file_io_type} = file
    validate_contexts!(contexts, file_io_type)

    %File{stream_specifiers: [stream_specifier | stream_specifiers]} = file
    stream_specifier = %StreamSpecifier{stream_specifier | options: [option | stream_specifier.options]}
    file = %File{file | stream_specifiers: [stream_specifier | stream_specifiers]}
    %Command{command | files: [file | files]}
  end

  @doc """
  Execute the command using ffmpeg CLI.

  Returns `{:ok, output}` on success, or `{:error, {cmd_output, exit_status}}` on error.
  """
  @spec execute(command :: Command.t) :: {:ok, binary()|nil} | {:error, {Collectable.t, exit_status :: non_neg_integer}}
  def execute(%Command{} = command) do
    ensure_erlexec_started!()

    {executable, args} = prepare(command)
    cli_command = [executable | args] |> Enum.map(&(to_charlist(&1)))
    output = :exec.run(cli_command, [:sync, :stdout, :stderr])

    format_output(output)
  end

  @doc """
  Prepares the command to be executed, by converting the `%Command{}` into
  proper parameters to be feeded to `System.cmd/3` or `Port.open/2`.

  Under normal circumstances `FFmpex.execute/1` should be used, use `prepare`
  only when converted args are needed to be feeded in a custom execution method.

  Returns `{ffmpeg_executable_path, list_of_args}`.
  """
  @spec prepare(command :: Command.t) :: {binary() | nil, list(binary)}
  def prepare(%Command{files: files, global_options: options}) do
    options = Enum.map(options, &arg_for_option/1)
    cmd_args = List.flatten([options, options_list(files)])
    {ffmpeg_path(), cmd_args}
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

  defp validate_contexts!(:unspecified, _), do: :ok
  defp validate_contexts!(contexts, required) when is_list(contexts) do
    unless Enum.member?(contexts, required), do: raise ArgumentError
  end

  defp format_output({:ok, data}) do
    case Keyword.get(data, :stdout) do
      nil -> {:ok, nil}
      binary_list -> {:ok, Enum.join(binary_list)}
    end
  end

  defp format_output({:error, data}) do
    exit_status = Keyword.get(data, :exit_status) |> :exec.status() |> elem(1)
    stderr = Keyword.get(data, :stderr, []) |> Enum.join("")
    {:error, {stderr, exit_status}}
  end

  # Ensure erlexec dependency can start; attempt recovery due to missing SHELL environment variable.
  defp ensure_erlexec_started! do
    if System.get_env()["SHELL"] == nil do
      System.put_env("SHELL", "/bin/sh")
    end

    if System.get_env()["USER"] == "root" do
      :exec.start([:root, {:user, "root"}, {:limit_users, ["root"]}])
    else
      :exec.start()
    end
  end

  # Read ffmpeg path from config. If unspecified, assume `ffmpeg` is in env $PATH.
  defp ffmpeg_path do
    case Application.get_env(:ffmpex, :ffmpeg_path, nil) do
      nil -> System.find_executable("ffmpeg")
      path -> path
    end
  end
end
