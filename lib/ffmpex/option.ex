defmodule FFmpex.Option do
  @moduledoc false

  @type name        :: binary
  @type argument    :: binary | nil
  @type require_arg :: boolean
  @type contexts    :: :unspecified | [context]
  @type context     :: :input | :output | :global | :per_stream

  @type t :: %__MODULE__{
    name:        name,
    argument:    argument,
    require_arg: require_arg,
    contexts:    contexts
  }

  defstruct name:        nil,
            argument:    nil,
            require_arg: false,
            contexts:    :unspecified

end