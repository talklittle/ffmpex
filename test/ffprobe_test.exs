defmodule FFprobeTest do
  use ExUnit.Case
  doctest FFprobe

  @fixture Path.join(__DIR__, "fixtures/test-mpeg.mpg")
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
end
