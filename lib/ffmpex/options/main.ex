defmodule FFmpex.Options.Main do
  alias FFmpex.Option

  @known_options %{
    f:               %Option{name: "-f", require_arg: true},
    i:               %Option{name: "-i", require_arg: true},
    y:               %Option{name: "-y"},
    n:               %Option{name: "-n"},
    stream_loop:     %Option{name: "-stream_loop", require_arg: true},
    codec:           %Option{name: "-codec", require_arg: true},
    t:               %Option{name: "-t", require_arg: true},
    to:              %Option{name: "-to", require_arg: true},
    fs:              %Option{name: "-fs", require_arg: true},
    ss:              %Option{name: "-ss", require_arg: true},
    sseof:           %Option{name: "-sseof", require_arg: true},
    itsoffset:       %Option{name: "-itsoffset", require_arg: true},
    timestamp:       %Option{name: "-timestamp", require_arg: true},
    metadata:        %Option{name: "-metadata", require_arg: true},
    program:         %Option{name: "-program", require_arg: true},
    target:          %Option{name: "-target", require_arg: true},
    dframes:         %Option{name: "-dframes", require_arg: true},
    frames:          %Option{name: "-frames", require_arg: true},
    qscale:          %Option{name: "-qscale", require_arg: true},
    filter:          %Option{name: "-filter", require_arg: true},
    filter_script:   %Option{name: "-filter_script", require_arg: true},
    pre:             %Option{name: "-pre", require_arg: true},
    stats:           %Option{name: "-stats"},
    progress:        %Option{name: "-progress", require_arg: true},
    stdin:           %Option{name: "-stdin"},
    debug_ts:        %Option{name: "-debug_ts"},
    attach:          %Option{name: "-attach", require_arg: true},
    dump_attachment: %Option{name: "-dump_attachment", require_arg: true},
    noautorotate:    %Option{name: "-noautorotate"},
  }

  require FFmpex.Options.Helpers
  FFmpex.Options.Helpers.option_functions(@known_options)

end