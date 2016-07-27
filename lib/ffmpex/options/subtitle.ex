defmodule FFmpex.Options.Subtitle do
  alias FFmpex.Option

  @known_options %{
    scodec:           %Option{name: "-scodec", require_arg: true},
    sn:               %Option{name: "-sn"},
    sbsf:             %Option{name: "-sbsf", require_arg: true},
    fix_sub_duration: %Option{name: "-fix_sub_duration"},
    canvas_size:      %Option{name: "-canvas_size", require_arg: true},
  }

  require FFmpex.Options.Helpers
  FFmpex.Options.Helpers.option_functions(@known_options)

end