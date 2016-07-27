defmodule FFmpex.Options.Audio do
  alias FFmpex.Option

  @known_options %{
    aframes:          %Option{name: "-aframes", require_arg: true},
    ar:               %Option{name: "-ar", require_arg: true},
    aq:               %Option{name: "-aq", require_arg: true},
    ac:               %Option{name: "-ac", require_arg: true},
    an:               %Option{name: "-an"},
    acodec:           %Option{name: "-acodec", require_arg: true},
    sample_fmt:       %Option{name: "-sample_fmt", require_arg: true},
    af:               %Option{name: "-af", require_arg: true},
    atag:             %Option{name: "-atag", require_arg: true},
    absf:             %Option{name: "-absf", require_arg: true},
    guess_layout_max: %Option{name: "-guess_layout_max", require_arg: true},
  }

  require FFmpex.Options.Helpers
  FFmpex.Options.Helpers.option_functions(@known_options)

end