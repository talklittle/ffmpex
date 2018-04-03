# Changelog

## 0.5.1 (2018-04-02)

* Added `FFmpex.prepare/1` to retrieve arguments list, useful for inspection or passing to `Port.open/2`.

## 0.5.0 (2018-03-26)

* **Breaking change:** Changed output format of `FFprobe.format/1` to be cleaner, based on ffmpeg JSON output.
  Specifically: `"nb_programs"`, `"nb_streams"`, and `"probe_score"` now contain integers instead of binaries;
  and tags are stored in a `"tags"` sub-map instead of being individual entries prefixed with "TAG:".
* Added `FFprobe.streams/1` to get a list of streams.
* Depends on Poison 3.1.
* Requires Elixir 1.4.

## 0.4.1 (2017-03-22)

* Fixed `FFprobe.format/1` for paths with spaces.

## 0.4.0 (2016-12-03)

* Added `FFmpex.Options.Video.Libavformat`.
* Validate options context (input, output, global) as specified in FFmpeg docs.

## 0.3.0 (2016-09-10)

* **Breaking change:** `add_stream_specifier/2` takes a keyword list instead of `%StreamSpecifier{}`.
* **Breaking change:** `execute/1` returns `:ok` or `{:error, {output, status}}`, instead of `{output, status}`.
* Added `use FFmpex.Options` to conveniently import all options.

## 0.2.1 (2016-08-17)

* Added `FFprobe.format/1` and `FFprobe.format_names/1`.

## 0.2.0 (2016-08-15)

* Added `FFprobe` module. `FFprobe.duration/1` to get video duration.

## 0.1.1 (2016-07-30)

* Lower Elixir requirement to 1.0 (was 1.3).

## 0.1.0 (2016-07-27)

* First FFmpex release.
* Specify per-file and per-stream options, and execute.
* Non-exhaustive catalog of known options.