defmodule CodeclimateCredo.Mixfile do
  use Mix.Project

  def version, do: "0.8.8"

  def project do
    [
      app: :codeclimate_credo,
      version: version(),
      elixir: "~> 1.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      escript: [
        main_module: Codeclimate.CLI,
        path: "bin/codeclimate_credo"
      ]
    ]
  end

  def application do
    [
      applications: []
    ]
  end

  defp deps do
    [
      {:credo, version()},
      {:poison, "~> 3.0"}
    ]
  end
end
