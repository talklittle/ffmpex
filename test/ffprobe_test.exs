defmodule FFprobeTest do
  use ExUnit.Case
  doctest FFprobe

  @fixture Path.join(__DIR__, "fixtures/test-mpeg.mpg")
  @fixture_mp4 Path.join(__DIR__, "fixtures/test-mp4.mp4")
  @fixture_space Path.join(__DIR__, "fixtures/test space.mp4")
  @fixture_still_image Path.join(__DIR__, "fixtures/ffmpex.png")

  test "correct duration" do
    assert 21.0 == FFprobe.duration(@fixture)
  end

  test "handles N/A duration" do
    assert :no_duration == FFprobe.duration(@fixture_still_image)
  end

  test "format has at least one expected key" do
    assert %{"nb_streams" => 2} = FFprobe.format(@fixture)
  end

  test "format which filename has space" do
    assert %{"nb_streams" => 2} = FFprobe.format(@fixture_space)
  end

  test "streams/1" do
    streams = FFprobe.streams(@fixture_space)

    assert is_list(streams)
    assert streams |> Enum.at(0) |> Map.get("codec_name") == "h264"
    assert streams |> Enum.at(1) |> Map.get("codec_name") == "aac"
  end

  test "format names include expected formats" do
    result = FFprobe.format_names(@fixture_mp4)
    assert "mp4" in result
    assert "mov" in result
    assert "m4a" in result
  end
end
