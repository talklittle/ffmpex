defmodule FFmpexTest do
  use ExUnit.Case
  doctest FFmpex

  @fixture Path.join(__DIR__, "fixtures/test-mpeg.mpg")
  @output_path Path.join(System.tmp_dir, "ffmpex-test-fixture.avi")

  alias FFmpex.StreamSpecifier

  import FFmpex
  import FFmpex.Options.Main
  import FFmpex.Options.Video.Libx264

  setup do
    on_exit fn ->
      File.rm @output_path
    end
  end

  # ffmpeg -i input.avi -b:v 64k -bufsize 64k output.avi
  test "set bitrate runs successfully" do
    command =
      FFmpex.new_command
      |> add_global_option(option_y)
      |> add_input_file(@fixture)
      |> add_output_file(@output_path)
        |> add_stream_specifier(%StreamSpecifier{stream_type: :video})
          |> add_stream_option(option_b("64k"))
        |> add_file_option(option_maxrate("128k"))
        |> add_file_option(option_bufsize("64k"))

    system_cmd_result = execute(command)
    assert {_, 0} = system_cmd_result
  end

end
