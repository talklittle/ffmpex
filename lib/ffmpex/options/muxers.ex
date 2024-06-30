defmodule FFmpex.Options.Muxers do
  @moduledoc """
  https://ffmpeg.org/ffmpeg-all.html#Muxers
  """
  alias FFmpex.Option

  @known_options %{
    hls_list_size:        %Option{name: "-hls_list_size", require_arg: true, contexts: [:input, :output]},
    hls_time:             %Option{name: "-hls_time", require_arg: true, contexts: [:input, :output]},
    start_number:         %Option{name: "-start_number", require_arg: true, contexts: [:input, :output]},
    hls_playlist_type:    %Option{name: "-hls_playlist_type", require_arg: true, contexts: [:input, :output]},
    hls_segment_type:     %Option{name: "-hls_segment_type", require_arg: true, contexts: [:input, :output]},
    hls_segment_filename: %Option{name: "-hls_segment_filename", require_arg: true, contexts: [:input, :output]},
    hls_init_time:        %Option{name: "-hls_init_time", require_arg: true, contexts: [:input, :output]},
    master_pl_name:       %Option{name: "-master_pl_name", require_arg: true, contexts: [:input, :output]},
    hls_base_url:         %Option{name: "-hls_base_url", require_arg: true, contexts: [:input, :output]},
    hls_flags:            %Option{name: "-hls_flags", require_arg: true, contexts: [:input, :output]},
    var_stream_map:       %Option{name: "-var_stream_map", require_arg: true, contexts: [:input, :output]},
    segment_format:       %Option{name: "-segment_format", require_arg: true, contexts: [:input, :output]},
    segment_time:         %Option{name: "-segment_time", require_arg: true, contexts: [:input, :output]},
    segment_list:         %Option{name: "-segment_list", require_arg: true, contexts: [:input, :output]},
  }

  require FFmpex.Options.Helpers
  FFmpex.Options.Helpers.option_functions(@known_options)
end
