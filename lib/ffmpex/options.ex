defmodule FFmpex.Options do
  @moduledoc """
  Convenience to import all FFmpex options.

  ```
  use FFmpex.Options
  ```
  """

  defmacro __using__(_) do
    quote do
      import FFmpex.Options.Advanced
      import FFmpex.Options.Audio
      import FFmpex.Options.Main
      import FFmpex.Options.Subtitle
      import FFmpex.Options.Video
      import FFmpex.Options.Video.Libx264
    end
  end

end