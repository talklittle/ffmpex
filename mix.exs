defmodule FFmpex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ffmpex,
      version: "0.6.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:jason, "~> 1.1.2"}
    ]
  end

  defp description do
    "FFmpeg command line wrapper."
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "CHANGELOG*", "LICENSE*"],
      maintainers: ["Andrew Shu"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/talklittle/ffmpex"}
    ]
  end
end
