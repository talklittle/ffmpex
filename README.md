# FFmpex

[![Build Status](https://travis-ci.org/talklittle/ffmpex.svg?branch=master)](https://travis-ci.org/talklittle/ffmpex)

An Elixir wrapper for the FFmpeg command line interface.

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