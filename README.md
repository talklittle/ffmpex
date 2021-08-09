# FFmpex

[![Build Status](https://github.com/talklittle/ffmpex/actions/workflows/ci.yml/badge.svg)](https://github.com/talklittle/ffmpex/actions?query=workflow%3ACI)
[![Module Version](https://img.shields.io/hexpm/v/ffmpex.svg)](https://hex.pm/packages/ffmpex)

An Elixir wrapper for the FFmpeg command line interface.

Documentation: https://hexdocs.pm/ffmpex/

## Usage notes

The API is a builder, building up the list of options per-file, per-stream(-per-file), and globally.

Note that adding options is backwards from using the ffmpeg CLI; when using ffmpeg CLI, you specify the options before each file. But with FFmpex (this library), you add the file/stream first, then add the relevant options afterward.

## Examples

```elixir
import FFmpex
use FFmpex.Options

command =
  FFmpex.new_command
  |> add_global_option(option_y())
  |> add_input_file("/path/to/input.avi")
  |> add_output_file("/path/to/output.avi")
    |> add_stream_specifier(stream_type: :video)
      |> add_stream_option(option_b("64k"))
    |> add_file_option(option_maxrate("128k"))
    |> add_file_option(option_bufsize("64k"))

:ok = execute(command)
```

You can use the `FFprobe` module to query for file info:

```elixir
FFprobe.duration("/path/to/input.avi")
# => result in seconds, e.g., 228.456939
```

See [silent_video](https://github.com/talklittle/silent_video)
and [thumbnex](https://github.com/talklittle/thumbnex)
for more usage examples.

## Prerequisites

[FFmpeg](https://ffmpeg.org/) must be installed.

## Installation

Add `ffmpex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ffmpex, "~> 0.7.2"}
  ]
end
```

## Configuration

You can specify some options in `config.exs`:

```elixir
config :ffmpex, ffmpeg_path: "/path/to/ffmpeg"
config :ffmpex, ffprobe_path: "/path/to/ffprobe"
```

## Release notes

See the [Changelog](./CHANGELOG.md) for changes between versions.

## Disclaimer

FFmpex is not affiliated with nor endorsed by the FFmpeg project.

FFmpeg is a trademark of [Fabrice Bellard](http://www.bellard.org/), originator of the FFmpeg project.

## Copyright and License

Copyright (c) 2016 Andrew Shu

FFmpex source code is licensed under the [MIT License](./LICENSE.md).
