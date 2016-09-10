# Changelog

## 0.3.0 (2016-09-10)

* **Breaking change:** `add_stream_specifier/2` takes a keyword list instead of `%StreamSpecifier{}`
* **Breaking change:** `execute/1` returns `:ok` or `{:error, {output, status}}`, instead of `{output, status}`
* Added `use FFmpex.Options` to conveniently import all options

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