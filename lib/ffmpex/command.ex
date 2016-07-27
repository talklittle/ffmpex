defmodule FFmpex.Command do
  @moduledoc """
  Opaque struct holding the command that is being built up.
  """
  alias FFmpex.File
  alias FFmpex.Option

  @type files          :: [File.t]
  @type global_options :: [Option.t]

  @type t :: %__MODULE__{
    files:          files,
    global_options: global_options
  }

  defstruct files:          [],
            global_options: []

end