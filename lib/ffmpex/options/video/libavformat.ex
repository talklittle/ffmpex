defmodule FFmpex.Options.Video.Libavformat do
  @moduledoc """
  https://ffmpeg.org/ffmpeg-all.html#Format-Options
  """

  alias FFmpex.Option

  @known_options %{
    avioflags:                   %Option{name: "-avioflags", require_arg: true, contexts: [:input, :output]},
    probesize:                   %Option{name: "-probesize", require_arg: true, contexts: [:input]},
    packetsize:                  %Option{name: "-packetsize", require_arg: true, contexts: [:output]},
    fflags:                      %Option{name: "-fflags", require_arg: true, contexts: [:input, :output]},
    seek2any:                    %Option{name: "-seek2any", require_arg: true, contexts: [:input]},
    analyzeduration:             %Option{name: "-analyzeduration", require_arg: true, contexts: [:input]},
    cryptokey:                   %Option{name: "-cryptokey", require_arg: true, contexts: [:input]},
    indexmem:                    %Option{name: "-indexmem", require_arg: true, contexts: [:input]},
    rtbufsize:                   %Option{name: "-rtbufsize", require_arg: true, contexts: [:input]},
    fdebug:                      %Option{name: "-fdebug", require_arg: true, contexts: [:input, :output]},
    max_delay:                   %Option{name: "-max_delay", require_arg: true, contexts: [:input, :output]},
    fpsprobesize:                %Option{name: "-fpsprobesize", require_arg: true, contexts: [:input]},
    audio_preload:               %Option{name: "-audio_preload", require_arg: true, contexts: [:output]},
    chunk_duration:              %Option{name: "-chunk_duration", require_arg: true, contexts: [:output]},
    chunk_size:                  %Option{name: "-chunk_size", require_arg: true, contexts: [:output]},
    err_detect:                  %Option{name: "-err_detect", require_arg: true, contexts: [:input]},
    f_err_detect:                %Option{name: "-f_err_detect", require_arg: true, contexts: [:input]},
    max_interleave_delta:        %Option{name: "-max_interleave_delta", require_arg: true, contexts: [:output]},
    use_wallclock_as_timestamps: %Option{name: "-use_wallclock_as_timestamps", require_arg: true, contexts: [:input]},
    avoid_negative_ts:           %Option{name: "-avoid_negative_ts", require_arg: true, contexts: [:output]},
    skip_initial_bytes:          %Option{name: "-skip_initial_bytes", require_arg: true, contexts: [:input]},
    correct_ts_overflow:         %Option{name: "-correct_ts_overflow", require_arg: true, contexts: [:input]},
    flush_packets:               %Option{name: "-flush_packets", require_arg: true, contexts: [:output]},
    output_ts_offset:            %Option{name: "-output_ts_offset", require_arg: true, contexts: [:output]},
    format_whitelist:            %Option{name: "-format_whitelist", require_arg: true, contexts: [:input]},
    dump_separator:              %Option{name: "-dump_separator", require_arg: true, contexts: [:input]},
  }

  require FFmpex.Options.Helpers
  FFmpex.Options.Helpers.option_functions(@known_options)

end