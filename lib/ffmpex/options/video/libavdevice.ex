defmodule FFmpex.Options.Video.Libavdevice do
  @moduledoc """
  https://www.ffmpeg.org/ffmpeg-devices.html
  """

  alias FFmpex.Option

  @known_options %{
    video_size: %Option{name: "-video_size", require_arg: true, contexts: [:input]},
    framerate:  %Option{name: "-framerate", require_arg: true, contexts: [:input]},
    draw_mouse: %Option{name: "-draw_mouse", require_arg: true, contexts: [:input]},
  }

  require FFmpex.Options.Helpers
  FFmpex.Options.Helpers.option_functions(@known_options)

end
