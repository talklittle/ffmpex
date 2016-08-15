defmodule FFprobeTest do
  use ExUnit.Case
  doctest FFprobe

  @fixture Path.join(__DIR__, "fixtures/test-mpeg.mpg")

  test "correct duration" do
    assert 21.0 == FFprobe.duration(@fixture)
  end
end
