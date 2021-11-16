# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.9.0 (2021-11-16)

* Run commands with [Rambo](https://github.com/jayjun/rambo) instead of erlexec, to address issues running in Docker.
* Requires Elixir 1.9.

### 0.8.2 (2021-11-15)

* Fixed starting erlexec when running as root.

### 0.8.1 (2021-11-11)

* Fixed `SHELL` environment variable check for erlexec.

## 0.8.0 (2021-11-10)

* **Breaking change:** `execute/1` returns `{:ok, output}` instead of `:ok`.
* Added `to_stdout/1` to direct ffmpeg output to a buffer instead of a file. Retrieve buffer in `{:ok, output}` result of `execute/1`. ([#31](https://github.com/talklittle/ffmpex/pull/31))

### 0.7.3 (2020-07-09)

* Relaxed Jason dependency so it can get all 1.x versions without mix.exs update.

### 0.7.2 (2020-07-09)

* Bumped Jason dependency to 1.2.

### 0.7.1 (2019-11-26)

* Changed to `-loop` instead of deprecated `-loop_input` and `-loop_output` options in `FFmpex.Options.Advanced`.

## 0.7.0 (2019-09-05)

* **Breaking change:** FFprobe API changes to return `{:ok, term}` or `{:error, atom}` from `format_names/1`, `format/1`, `streams/1`.
* Changed `FFprobe.duration/1` to return `{:error, :no_such_file}` for nonexistent file, instead of raising MatchError.
* Fixed FFprobe module to raise a clearer error message when FFmpeg not installed in system path.

## 0.6.0 (2019-07-16)

* Changed to Jason instead of Poison for JSON operations.

### 0.5.2 (2018-04-10)

* Added options `video_size`, `framerate`, `draw_mouse` in `FFmpex.Options.Devices.Libavdevice`.

### 0.5.1 (2018-04-02)

* Added `FFmpex.prepare/1` to retrieve arguments list, useful for inspection or passing to `Port.open/2`.

## 0.5.0 (2018-03-26)

* **Breaking change:** Changed output format of `FFprobe.format/1` to be cleaner, based on ffmpeg JSON output.
  Specifically: `"nb_programs"`, `"nb_streams"`, and `"probe_score"` now contain integers instead of binaries;
  and tags are stored in a `"tags"` sub-map instead of being individual entries prefixed with "TAG:".
* Added `FFprobe.streams/1` to get a list of streams.
* Depends on Poison 3.1.
* Requires Elixir 1.4.

### 0.4.1 (2017-03-22)

* Fixed `FFprobe.format/1` for paths with spaces.

## 0.4.0 (2016-12-03)

* Added `FFmpex.Options.Video.Libavformat`.
* Validate options context (input, output, global) as specified in FFmpeg docs.

## 0.3.0 (2016-09-10)

* **Breaking change:** `add_stream_specifier/2` takes a keyword list instead of `%StreamSpecifier{}`.
* **Breaking change:** `execute/1` returns `:ok` or `{:error, {output, status}}`, instead of `{output, status}`.
* Added `use FFmpex.Options` to conveniently import all options.

### 0.2.1 (2016-08-17)

* Added `FFprobe.format/1` and `FFprobe.format_names/1`.

## 0.2.0 (2016-08-15)

* Added `FFprobe` module. `FFprobe.duration/1` to get video duration.

### 0.1.1 (2016-07-30)

* Lower Elixir requirement to 1.0 (was 1.3).

## 0.1.0 (2016-07-27)

* First FFmpex release.
* Specify per-file and per-stream options, and execute.
* Non-exhaustive catalog of known options.
