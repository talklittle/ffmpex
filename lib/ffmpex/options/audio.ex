defmodule FFmpex.Options.Audio do
  @moduledoc """
  https://ffmpeg.org/ffmpeg-all.html#Audio-Options
  """
  alias FFmpex.Option

  @known_options %{
    aframes:          %Option{name: "-aframes", require_arg: true, contexts: [:output]},
    ar:               %Option{name: "-ar", require_arg: true, contexts: [:input, :output, :per_stream]},
    aq:               %Option{name: "-aq", require_arg: true, contexts: [:output]},
    ac:               %Option{name: "-ac", require_arg: true, contexts: [:input, :output, :per_stream]},
    an:               %Option{name: "-an", contexts: [:output]},
    acodec:           %Option{name: "-acodec", require_arg: true, contexts: [:input, :output]},
    sample_fmt:       %Option{name: "-sample_fmt", require_arg: true, contexts: [:output, :per_stream]},
    af:               %Option{name: "-af", require_arg: true, contexts: [:output]},
    atag:             %Option{name: "-atag", require_arg: true, contexts: [:output]},
    absf:             %Option{name: "-absf", require_arg: true},
    guess_layout_max: %Option{name: "-guess_layout_max", require_arg: true, contexts: [:input, :per_stream]},
  }

  require FFmpex.Options.Helpers
  FFmpex.Options.Helpers.option_functions(@known_options)

end