defmodule Mix.Tasks.Codeclimate do
  @moduledoc """
  Task to analyze files
  """
  use Mix.Task

  @code_dir "/code"

  def run(_argv) do
    "mix"
    |> System.cmd(["credo", @code_dir, "-A", "--all", "--one-line"])
    |> OutputConverter.convert
  end
end
