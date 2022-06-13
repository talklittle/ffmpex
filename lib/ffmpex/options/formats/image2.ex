defmodule FFmpex.Options.Formats.Image2 do
  @moduledoc """
  https://www.ffmpeg.org/ffmpeg-formats.html#image2-1
  """

  alias FFmpex.Option

  @known_options %{
    pattern_type: %Option{name: "-pattern_type", require_arg: true, contexts: [:input]},
  }

  require FFmpex.Options.Helpers
  FFmpex.Options.Helpers.option_functions(@known_options)

end
