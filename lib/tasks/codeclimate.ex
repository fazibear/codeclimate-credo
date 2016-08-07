defmodule Mix.Tasks.Codeclimate do
  @moduledoc """
  Task to analyze files
  """
  use Mix.Task
  alias CodeclimateCredo.OutputConverter

  @code_dir "/code"

  def run(_argv) do
    try do
      run_credo
    rescue
      error -> log_error(error)
    end
  end

  def run_credo do
    "mix"
    |> System.cmd(["credo", @code_dir, "-A", "--all", "--one-line"])
    |> OutputConverter.convert
    |> IO.puts
  end

  defp log_error(error) do
    IO.inspect(:stderr, error)
  end
end
