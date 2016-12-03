defmodule FFmpex.Options.Advanced do
  @moduledoc """
  https://ffmpeg.org/ffmpeg-all.html#Advanced-options
  """
  alias FFmpex.Option

  @known_options %{
    map:                   %Option{name: "-map", require_arg: true},
    ignore_unknown:        %Option{name: "-ignore_unknown"},
    copy_unknown:          %Option{name: "-copy_unknown"},
    map_channel:           %Option{name: "-map_channel", require_arg: true},
    map_metadata:          %Option{name: "-map_metadata", require_arg: true},
    map_chapters:          %Option{name: "-map_chapters", require_arg: true},
    benchmark:             %Option{name: "-benchmark"},
    benchmark_all:         %Option{name: "-benchmark_all"},
    timelimit:             %Option{name: "-timelimit", require_arg: true},
    dump:                  %Option{name: "-dump"},
    hex:                   %Option{name: "-hex"},
    re:                    %Option{name: "-re"},
    loop_input:            %Option{name: "-loop_input"},
    loop_output:           %Option{name: "-loop_output", require_arg: true},
    vsync:                 %Option{name: "-vsync", require_arg: true},
    frame_drop_threshold:  %Option{name: "-frame_drop_threshold", require_arg: true},
    async:                 %Option{name: "-async", require_arg: true},
    copyts:                %Option{name: "-copyts"},
    start_at_zero:         %Option{name: "-start_at_zero"},
    copytb:                %Option{name: "-copytb", require_arg: true},
    shortest:              %Option{name: "-shortest"},
    dts_delta_threshold:   %Option{name: "-dts_delta_threshold"},
    muxdelay:              %Option{name: "-muxdelay", require_arg: true},
    muxpreload:            %Option{name: "-muxpreload", require_arg: true},
    streamid:              %Option{name: "-streamid", require_arg: true},
    bsf:                   %Option{name: "-bsf", require_arg: true},
    tag:                   %Option{name: "-tag", require_arg: true},
    timecode:              %Option{name: "-timecode", require_arg: true},
    filter_complex:        %Option{name: "-filter_complex", require_arg: true},
    lavfi:                 %Option{name: "-lavfi", require_arg: true},
    filter_complex_script: %Option{name: "-filter_complex_script", require_arg: true},
    accurate_seek:         %Option{name: "-accurate_seek"},
    seek_timestamp:        %Option{name: "-seek_timestamp"},
    thread_queue_size:     %Option{name: "-thread_queue_size", require_arg: true},
    override_ffserver:     %Option{name: "-override_ffserver"},
    sdp_file:              %Option{name: "-sdp_file", require_arg: true},
    discard:               %Option{name: "-discard"},
    abort_on:              %Option{name: "-abort_on", require_arg: true},
    xerror:                %Option{name: "-xerror"},
  }

  require FFmpex.Options.Helpers
  FFmpex.Options.Helpers.option_functions(@known_options)

end