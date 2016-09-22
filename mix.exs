defmodule CodeclimateCredo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :codeclimate_credo,
      version: "0.0.1",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      escript: [
        main_module: Codeclimate.CLI,
        path: "bin/codeclimate_credo"
      ]
    ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:credo, "~> 0.4.0"},
      {:poison, "~> 2.2.0"}
    ]
  end
end
