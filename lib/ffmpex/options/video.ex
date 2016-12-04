defmodule FFmpex.Options.Video do
  @moduledoc """
  https://ffmpeg.org/ffmpeg-all.html#Video-Options
  """
  alias FFmpex.Option

  @known_options %{
    vframes:          %Option{name: "-vframes", require_arg: true, contexts: [:output]},
    r:                %Option{name: "-r", require_arg: true, contexts: [:input, :output, :per_stream]},
    s:                %Option{name: "-s", require_arg: true, contexts: [:input, :output, :per_stream]},
    aspect:           %Option{name: "-aspect", require_arg: true, contexts: [:output, :per_stream]},
    vn:               %Option{name: "-vn", contexts: [:output]},
    vcodec:           %Option{name: "-vcodec", require_arg: true, contexts: [:output]},
    pass:             %Option{name: "-pass", require_arg: true, contexts: [:output, :per_stream]},
    passlogfile:      %Option{name: "-passlogfile", require_arg: true, contexts: [:output, :per_stream]},
    vf:               %Option{name: "-vf", require_arg: true, contexts: [:output]},
    pix_fmt:          %Option{name: "-pix_fmt", require_arg: true, contexts: [:input, :output, :per_stream]},
    sws_flags:        %Option{name: "-sws_flags", require_arg: true, contexts: [:input, :output]},
    vdt:              %Option{name: "-vdt", require_arg: true},
    rc_override:      %Option{name: "-rc_override", require_arg: true, contexts: [:output, :per_stream]},
    ilme:             %Option{name: "-ilme"},
    psnr:             %Option{name: "-psnr"},
    vstats:           %Option{name: "-vstats"},
    vstats_file:      %Option{name: "-vstats_file", require_arg: true},
    top:              %Option{name: "-top", require_arg: true, contexts: [:output, :per_stream]},
    dc:               %Option{name: "-dc", require_arg: true},
    vtag:             %Option{name: "-vtag", require_arg: true, contexts: [:output]},
    qphist:           %Option{name: "-qphist", contexts: [:global]},
    vbsf:             %Option{name: "-vbsf", require_arg: true},
    force_key_frames: %Option{name: "-force_key_frames", require_arg: true, contexts: [:output, :per_stream]},
    copyinkf:         %Option{name: "-copyinkf", contexts: [:output, :per_stream]},
    hwaccel:          %Option{name: "-hwaccel", require_arg: true, contexts: [:input, :per_stream]},
    hwaccel_device:   %Option{name: "-hwaccel_device", require_arg: true, contexts: [:input, :per_stream]},
    hwaccels:         %Option{name: "-hwaccels"},
  }

  require FFmpex.Options.Helpers
  FFmpex.Options.Helpers.option_functions(@known_options)

end