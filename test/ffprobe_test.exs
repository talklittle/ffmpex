defmodule FFprobeTest do
  use ExUnit.Case
  doctest FFprobe

  @fixture Path.join(__DIR__, "fixtures/test-mpeg.mpg")
  @fixture_mp4 Path.join(__DIR__, "fixtures/test-mp4.mp4")
  @fixture_still_image Path.join(__DIR__, "fixtures/ffmpex.png")

  test "correct duration" do
    assert 21.0 == FFprobe.duration(@fixture)
  end

  test "handles N/A duration" do
    assert :no_duration == FFprobe.duration(@fixture_still_image)
  end

  test "format has at least one expected key" do
    assert %{"nb_streams" => "2"} = FFprobe.format(@fixture)
  end

  test "format names include expected formats" do
    result = FFprobe.format_names(@fixture_mp4)
    assert "mp4" in result
    assert "mov" in result
    assert "m4a" in result
  end
end
