defmodule Mix.Tasks.CodeClimate do
  use Mix.Task

  @shortdoc "Run code analysis (use `--help` for options)"
  @moduledoc @shortdoc

  @doc false
  def run(argv) do
    CodeClimate.main(argv)
  end
end
