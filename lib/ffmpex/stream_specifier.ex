defmodule FFmpex.StreamSpecifier do
  @moduledoc false

  alias FFmpex.Option

  @type options        :: [Option.t]
  @type stream_index   :: non_neg_integer | nil
  @type stream_type    :: :video | :video_without_pics | :audio | :subtitle | :data | :attachments | nil
  @type program_id     :: non_neg_integer | nil
  @type stream_id      :: non_neg_integer | nil
  @type metadata_key   :: binary | nil
  @type metadata_value :: binary | nil
  @type usable         :: boolean

  @type t :: %__MODULE__{
    options:        options,
    stream_index:   stream_index,
    stream_type:    stream_type,
    program_id:     program_id,
    stream_id:      stream_id,
    metadata_key:   metadata_key,
    metadata_value: metadata_value,
    usable:         usable
  }

  defstruct options:        [],
            stream_index:   nil,
            stream_type:    nil,
            program_id:     nil,
            stream_id:      nil,
            metadata_key:   nil,
            metadata_value: nil,
            usable:         false

  def add_option(%__MODULE__{options: options} = stream_specifier, %Option{} = option) do
    %__MODULE__{stream_specifier | options: [option | options]}
  end

  def add_option(%__MODULE__{options: options} = stream_specifier, option_name) when is_binary(option_name) do
    option = %Option{name: option_name}
    %__MODULE__{stream_specifier | options: [option | options]}
  end

  def add_option(%__MODULE__{options: options} = stream_specifier, %Option{} = option, argument) do
    option = %Option{option | argument: argument}
    %__MODULE__{stream_specifier | options: [option | options]}
  end

  def add_option(%__MODULE__{options: options} = stream_specifier, option_name, argument) when is_binary(option_name) do
    option = %Option{name: option_name, argument: argument}
    %__MODULE__{stream_specifier | options: [option | options]}
  end

  def specifier_string(%__MODULE__{stream_type: :video, stream_index: nil}), do: "v"
  def specifier_string(%__MODULE__{stream_type: :video_without_pics, stream_index: nil}), do: "V"
  def specifier_string(%__MODULE__{stream_type: :audio, stream_index: nil}), do: "a"
  def specifier_string(%__MODULE__{stream_type: :subtitle, stream_index: nil}), do: "s"
  def specifier_string(%__MODULE__{stream_type: :data, stream_index: nil}), do: "d"
  def specifier_string(%__MODULE__{stream_type: :attachments, stream_index: nil}), do: "t"
  def specifier_string(%__MODULE__{stream_type: :video, stream_index: index}), do: "v:#{index}"
  def specifier_string(%__MODULE__{stream_type: :video_without_pics, stream_index: index}), do: "V:#{index}"
  def specifier_string(%__MODULE__{stream_type: :audio, stream_index: index}), do: "a:#{index}"
  def specifier_string(%__MODULE__{stream_type: :subtitle, stream_index: index}), do: "s:#{index}"
  def specifier_string(%__MODULE__{stream_type: :data, stream_index: index}), do: "d:#{index}"
  def specifier_string(%__MODULE__{stream_type: :attachments, stream_index: index}), do: "t:#{index}"
  def specifier_string(%__MODULE__{program_id: pid, stream_index: nil}) when is_integer(pid), do: "p:#{pid}"
  def specifier_string(%__MODULE__{program_id: pid, stream_index: index}) when is_integer(pid), do: "p:#{pid}:#{index}"
  def specifier_string(%__MODULE__{stream_id: sid}) when is_integer(sid), do: "i:#{sid}"
  def specifier_string(%__MODULE__{metadata_key: key, metadata_value: nil}) when is_binary(key), do: "m:#{key}"
  def specifier_string(%__MODULE__{metadata_key: key, metadata_value: value}) when is_binary(key), do: "m:#{key}:#{value}"
  def specifier_string(%__MODULE__{usable: true}), do: "u"
  def specifier_string(%__MODULE__{stream_index: index}) when is_integer(index), do: "#{index}"

  def command_arguments(specifier, acc \\ [])
  def command_arguments(%__MODULE__{options: []}, acc), do: acc
  def command_arguments(%__MODULE__{options: [option | options]} = specifier, acc) do
    command_arguments(%__MODULE__{specifier | options: options}, acc ++ arg_for_option(specifier, option))
  end

  defp arg_for_option(specifier, %Option{name: name, require_arg: false, argument: nil}) do
    ~w(#{name}:#{specifier_string(specifier)})
  end
  defp arg_for_option(specifier, %Option{name: name, argument: arg}) when not is_nil(arg) do
    ~w(#{name}:#{specifier_string(specifier)} #{arg})
  end
end