# FFmpex

[![Build Status](https://travis-ci.org/talklittle/ffmpex.svg?branch=master)](https://travis-ci.org/talklittle/ffmpex)

An Elixir wrapper for the FFmpeg command line interface.

Documentation: https://hexdocs.pm/ffmpex/

## Example

```elixir
alias FFmpex.StreamSpecifier

import FFmpex
import FFmpex.Options.Main
import FFmpex.Options.Video.Libx264

command =
  FFmpex.new_command
  |> add_global_option(option_y)
  |> add_input_file("/path/to/input.avi")
  |> add_output_file("/path/to/output.avi")
    |> add_stream_specifier(%StreamSpecifier{stream_type: :video})
      |> add_stream_option(option_b("64k"))
    |> add_file_option(option_maxrate("128k"))
    |> add_file_option(option_bufsize("64k"))

system_cmd_result = execute(command)
{_, 0} = system_cmd_result
```

## Prerequisites

[FFmpeg](https://ffmpeg.org/) must be installed.

## Installation

FFmpex can be installed as:

  1. Add `ffmpex` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ffmpex, "~> 0.1.0"}]
    end
    ```

  2. Ensure `ffmpex` is started before your application:

    ```elixir
    def application do
      [applications: [:ffmpex]]
    end
    ```

## Release notes

See the [changelog](CHANGELOG.md) for changes between versions.

## Disclaimer

FFmpex is not affiliated with nor endorsed by the FFmpeg project.

FFmpeg is a trademark of [Fabrice Bellard](http://www.bellard.org/), originator of the FFmpeg project.

## License

FFmpex source code is licensed under the [MIT License](LICENSE.md).