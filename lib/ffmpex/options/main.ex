defmodule FFmpex.Options.Main do
  @moduledoc """
  https://ffmpeg.org/ffmpeg-all.html#Main-options
  """
  alias FFmpex.Option

  @known_options %{
    f:               %Option{name: "-f", require_arg: true, contexts: [:input, :output]},
    i:               %Option{name: "-i", require_arg: true, contexts: [:input]},
    y:               %Option{name: "-y", contexts: [:global]},
    n:               %Option{name: "-n", contexts: [:global]},
    stream_loop:     %Option{name: "-stream_loop", require_arg: true, contexts: [:input]},
    c:               %Option{name: "-c", require_arg: true, contexts: [:input, :output, :per_stream]},
    codec:           %Option{name: "-codec", require_arg: true, contexts: [:input, :output, :per_stream]},
    t:               %Option{name: "-t", require_arg: true, contexts: [:input, :output]},
    to:              %Option{name: "-to", require_arg: true, contexts: [:output]},
    fs:              %Option{name: "-fs", require_arg: true, contexts: [:output]},
    ss:              %Option{name: "-ss", require_arg: true, contexts: [:input, :output]},
    sseof:           %Option{name: "-sseof", require_arg: true, contexts: [:input, :output]},
    itsoffset:       %Option{name: "-itsoffset", require_arg: true, contexts: [:input]},
    timestamp:       %Option{name: "-timestamp", require_arg: true, contexts: [:output]},
    metadata:        %Option{name: "-metadata", require_arg: true, contexts: [:output, :per_metadata]},
    disposition:     %Option{name: "-disposition", require_arg: true, contexts: [:output, :per_stream]},
    program:         %Option{name: "-program", require_arg: true, contexts: [:output]},
    target:          %Option{name: "-target", require_arg: true, contexts: [:output]},
    dframes:         %Option{name: "-dframes", require_arg: true, contexts: [:output]},
    frames:          %Option{name: "-frames", require_arg: true, contexts: [:output, :per_stream]},
    q:               %Option{name: "-q", require_arg: true, contexts: [:output, :per_stream]},
    qscale:          %Option{name: "-qscale", require_arg: true, contexts: [:output, :per_stream]},
    filter:          %Option{name: "-filter", require_arg: true, contexts: [:output, :per_stream]},
    filter_script:   %Option{name: "-filter_script", require_arg: true, contexts: [:output, :per_stream]},
    filter_threads:  %Option{name: "-filter_threads", require_arg: true, contexts: [:global]},
    pre:             %Option{name: "-pre", require_arg: true, contexts: [:output, :per_stream]},
    strict:          %Option{name: "-strict", require_arg: true, contexts: [:output, :per_stream]},
    stats:           %Option{name: "-stats", contexts: [:global]},
    progress:        %Option{name: "-progress", require_arg: true, contexts: [:global]},
    stdin:           %Option{name: "-stdin"},
    debug_ts:        %Option{name: "-debug_ts", contexts: [:global]},
    attach:          %Option{name: "-attach", require_arg: true, contexts: [:output]},
    dump_attachment: %Option{name: "-dump_attachment", require_arg: true, contexts: [:input, :per_stream]},
    noautorotate:    %Option{name: "-noautorotate"},
  }

  require FFmpex.Options.Helpers
  FFmpex.Options.Helpers.option_functions(@known_options)

end