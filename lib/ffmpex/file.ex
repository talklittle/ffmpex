defmodule FFmpex.File do
  @moduledoc false

  alias FFmpex.Option
  alias FFmpex.StreamSpecifier

  @type path              :: binary
  @type options           :: [Option.t]
  @type stream_specifiers :: [StreamSpecifier.t]
  @type type              :: :input | :output

  @type t :: %__MODULE__{
    path:              path,
    options:           options,
    stream_specifiers: stream_specifiers,
    type:              type
  }

  defstruct path:              nil,
            options:           [],
            stream_specifiers: [],
            type:              nil

  def add_option(%__MODULE__{options: options} = file, %Option{} = option) do
    %__MODULE__{file | options: [option | options]}
  end

  def add_option(%__MODULE__{options: options} = file, option_name) when is_binary(option_name) do
    option = %Option{name: option_name}
    %__MODULE__{file | options: [option | options]}
  end

  def add_option(%__MODULE__{options: options} = file, %Option{} = option, argument) do
    option = %Option{option | argument: argument}
    %__MODULE__{file | options: [option | options]}
  end

  def add_option(%__MODULE__{options: options} = file, option_name, argument) when is_binary(option_name) do
    option = %Option{name: option_name, argument: argument}
    %__MODULE__{file | options: [option | options]}
  end

  def command_arguments(file, acc \\ [])
  def command_arguments(%__MODULE__{options: [], stream_specifiers: []}, acc), do: acc
  def command_arguments(%__MODULE__{options: [option | options]} = file, acc) do
    command_arguments(%__MODULE__{file | options: options}, acc ++ arg_for_option(option))
  end
  def command_arguments(%__MODULE__{stream_specifiers: [specifier | specifiers]} = file, acc) do
    command_arguments(%__MODULE__{file | stream_specifiers: specifiers}, acc ++ args_for_specifier(specifier))
  end

  defp arg_for_option(%Option{name: name, require_arg: false, argument: nil}) do
    ~w(#{name})
  end
  defp arg_for_option(%Option{name: name, argument: arg}) when not is_nil(arg) do
    ~w(#{name} #{arg})
  end

  defp args_for_specifier(%StreamSpecifier{} = specifier) do
    StreamSpecifier.command_arguments(specifier)
  end
end