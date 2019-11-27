defmodule FFmpex.Options.Advanced do
  @moduledoc """
  https://ffmpeg.org/ffmpeg-all.html#Advanced-options
  """
  alias FFmpex.Option

  @known_options %{
    map:                    %Option{name: "-map", require_arg: true, contexts: [:output]},
    ignore_unknown:         %Option{name: "-ignore_unknown"},
    copy_unknown:           %Option{name: "-copy_unknown"},
    map_channel:            %Option{name: "-map_channel", require_arg: true},
    map_metadata:           %Option{name: "-map_metadata", require_arg: true, contexts: [:output, :per_metadata]},
    map_chapters:           %Option{name: "-map_chapters", require_arg: true, contexts: [:output]},
    benchmark:              %Option{name: "-benchmark", contexts: [:global]},
    benchmark_all:          %Option{name: "-benchmark_all", contexts: [:global]},
    timelimit:              %Option{name: "-timelimit", require_arg: true, contexts: [:global]},
    dump:                   %Option{name: "-dump", contexts: [:global]},
    hex:                    %Option{name: "-hex", contexts: [:global]},
    re:                     %Option{name: "-re", contexts: [:input]},
    loop:                   %Option{name: "-loop", require_arg: true},
    vsync:                  %Option{name: "-vsync", require_arg: true},
    frame_drop_threshold:   %Option{name: "-frame_drop_threshold", require_arg: true},
    async:                  %Option{name: "-async", require_arg: true},
    copyts:                 %Option{name: "-copyts"},
    start_at_zero:          %Option{name: "-start_at_zero"},
    copytb:                 %Option{name: "-copytb", require_arg: true},
    shortest:               %Option{name: "-shortest", contexts: [:output]},
    dts_delta_threshold:    %Option{name: "-dts_delta_threshold"},
    muxdelay:               %Option{name: "-muxdelay", require_arg: true, contexts: [:input]},
    muxpreload:             %Option{name: "-muxpreload", require_arg: true, contexts: [:input]},
    streamid:               %Option{name: "-streamid", require_arg: true, contexts: [:output]},
    bsf:                    %Option{name: "-bsf", require_arg: true, contexts: [:output, :per_stream]},
    tag:                    %Option{name: "-tag", require_arg: true, contexts: [:input, :output, :per_stream]},
    timecode:               %Option{name: "-timecode", require_arg: true},
    filter_complex:         %Option{name: "-filter_complex", require_arg: true, contexts: [:global]},
    filter_complex_threads: %Option{name: "-filter_complex_threads", require_arg: true, contexts: [:global]},
    lavfi:                  %Option{name: "-lavfi", require_arg: true, contexts: [:global]},
    filter_complex_script:  %Option{name: "-filter_complex_script", require_arg: true, contexts: [:global]},
    accurate_seek:          %Option{name: "-accurate_seek", contexts: [:input]},
    seek_timestamp:         %Option{name: "-seek_timestamp", contexts: [:input]},
    thread_queue_size:      %Option{name: "-thread_queue_size", require_arg: true, contexts: [:input]},
    override_ffserver:      %Option{name: "-override_ffserver", contexts: [:global]},
    sdp_file:               %Option{name: "-sdp_file", require_arg: true, contexts: [:global]},
    discard:                %Option{name: "-discard", contexts: [:input]},
    abort_on:               %Option{name: "-abort_on", require_arg: true, contexts: [:global]},
    xerror:                 %Option{name: "-xerror", contexts: [:global]},
    max_muxing_queue_size:  %Option{name: "-max_muxing_queue_size", require_arg: true, contexts: [:output, :per_stream]},
  }

  require FFmpex.Options.Helpers
  FFmpex.Options.Helpers.option_functions(@known_options)

end