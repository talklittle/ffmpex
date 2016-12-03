defmodule FFmpex.Options.Video do
  @moduledoc """
  https://ffmpeg.org/ffmpeg-all.html#Video-Options
  """
  alias FFmpex.Option

  @known_options %{
    vframes:          %Option{name: "-vframes", require_arg: true},
    r:                %Option{name: "-r", require_arg: true},
    s:                %Option{name: "-s", require_arg: true},
    aspect:           %Option{name: "-aspect", require_arg: true},
    vn:               %Option{name: "-vn"},
    vcodec:           %Option{name: "-vcodec", require_arg: true},
    pass:             %Option{name: "-pass", require_arg: true},
    passlogfile:      %Option{name: "-passlogfile", require_arg: true},
    vf:               %Option{name: "-vf", require_arg: true},
    pix_fmt:          %Option{name: "-pix_fmt", require_arg: true},
    sws_flags:        %Option{name: "-sws_flags", require_arg: true},
    vdt:              %Option{name: "-vdt", require_arg: true},
    rc_override:      %Option{name: "-rc_override", require_arg: true},
    ilme:             %Option{name: "-ilme"},
    psnr:             %Option{name: "-psnr"},
    vstats:           %Option{name: "-vstats"},
    vstats_file:      %Option{name: "-vstats_file", require_arg: true},
    top:              %Option{name: "-top", require_arg: true},
    dc:               %Option{name: "-dc", require_arg: true},
    vtag:             %Option{name: "-vtag", require_arg: true},
    qphist:           %Option{name: "-qphist"},
    vbsf:             %Option{name: "-vbsf", require_arg: true},
    force_key_frames: %Option{name: "-force_key_frames", require_arg: true},
    copyinkf:         %Option{name: "-copyinkf"},
    hwaccel:          %Option{name: "-hwaccel", require_arg: true},
    hwaccel_device:   %Option{name: "-hwaccel_device", require_arg: true},
    hwaccels:         %Option{name: "-hwaccels"},
  }

  require FFmpex.Options.Helpers
  FFmpex.Options.Helpers.option_functions(@known_options)

end