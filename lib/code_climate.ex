defmodule CodeClimate do
  @moduledoc """
  Documentation for Codeclimate.
  """

  def main(_args) do
    {out, _exit} = System.cmd("mix", ~w[credo --format=codeclimate --strict /code], stderr_to_stdout: false)

    IO.puts(out)
  end
end
