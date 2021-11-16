defmodule FFmpex.Mixfile do
  use Mix.Project

  @source_url "https://github.com/talklittle/ffmpex"
  @version "0.8.2"

  def project do
    [
      app: :ffmpex,
      version: @version,
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:jason, "~> 1.2"},
      {:erlexec, "~> 1.0", runtime: false}
    ]
  end

  defp package do
    [
      description: "FFmpeg command line wrapper.",
      files: ["lib", "mix.exs", "README*", "CHANGELOG*", "LICENSE*"],
      maintainers: ["Andrew Shu"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "https://hexdocs.pm/ffmpex/changelog.html",
        "GitHub" => @source_url
      }
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md": [title: "Changelog"],
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end
end
