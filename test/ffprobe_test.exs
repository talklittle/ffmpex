defmodule FFprobeTest do
  use ExUnit.Case
  doctest FFprobe

  @fixture Path.join(__DIR__, "fixtures/test-mpeg.mpg")
  @fixture_mp4 Path.join(__DIR__, "fixtures/test-mp4.mp4")
  @fixture_space Path.join(__DIR__, "fixtures/test space.mp4")
  @fixture_still_image Path.join(__DIR__, "fixtures/ffmpex.png")
  @fixture_https "https://github.com/talklittle/ffmpex/raw/7bf57fa3024ae881c262b71e854f6bfb0a924dd7/test/fixtures/test-mpeg.mpg"
  @fixture_non_media_url "https://github.com/talklittle/ffmpex/raw/7bf57fa3024ae881c262b71e854f6bfb0a924dd7/test/ffprobe_test.exs"
  @fixture_non_media_file __ENV__.file

  test "correct duration" do
    duration = FFprobe.duration(@fixture)
    assert duration > 20.9 && duration <= 21.0
  end

  test "handles N/A duration" do
    assert :no_duration == FFprobe.duration(@fixture_still_image)
  end

  test "format has at least one expected key" do
    assert {:ok, %{"nb_streams" => 2} } = FFprobe.format(@fixture)
  end

  test "format which filename has space" do
    assert {:ok,%{"nb_streams" => 2}} = FFprobe.format(@fixture_space)
  end

  test "format handles a remote file from URL" do
    assert {:ok, %{"nb_streams" => 2} } = FFprobe.format(@fixture_https)
  end

  test "streams/1" do
    assert {:ok,streams} = FFprobe.streams(@fixture_space)

    assert is_list(streams)
    assert streams |> Enum.at(0) |> Map.get("codec_name") == "h264"
    assert streams |> Enum.at(1) |> Map.get("codec_name") == "aac"
  end

  test "streams/1 handles a remote file from URL" do
    assert {:ok,streams} = FFprobe.streams(@fixture_https)

    assert is_list(streams)
    assert streams |> Enum.at(0) |> Map.get("codec_name") == "mpeg1video"
    assert streams |> Enum.at(1) |> Map.get("codec_name") == "mp2"
  end

  test "stream/1 should return a error when the given file does not exist" do
    assert {:error, :no_such_file} == FFprobe.streams("hej")
  end

  test "format/1 should return a error when the given file does not exist" do
    assert {:error, :no_such_file} == FFprobe.format("hej")
  end

  test "format/1 should return a error when the given remote URL does not exist" do
    bad_url = String.replace(@fixture_https, "test-mpeg", "does-not-exist")
    assert {:error, :no_such_file} == FFprobe.format(bad_url)
  end

  test "format_names/1 should return a error when the given file does not exist" do
    assert {:error, :no_such_file} == FFprobe.format_names("hej")
  end

  test "format/1 should return an invalid file error when the given file is not a media file" do
    assert {:error, :invalid_file} == FFprobe.format(@fixture_non_media_file)
  end

  test "format/1 should return an invalid file error when the given remote URL is not a media file" do
    assert {:error, :invalid_file} == FFprobe.format(@fixture_non_media_url)
  end

  test "format names include expected formats" do
    assert {:ok, result} = FFprobe.format_names(@fixture_mp4)
    assert "mp4" in result
    assert "mov" in result
    assert "m4a" in result
  end
end
