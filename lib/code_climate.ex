defmodule CodeClimate do
  @moduledoc """
  Documentation for Codeclimate.
  """

  def main(_args) do
    {out, _exit} = System.cmd("mix", ~w[credo --format=json --strict /code], stderr_to_stdout: false)

    out
    |> IO.inspect
    |> Jason.decode!()
    |> IO.inspect
  end
end
