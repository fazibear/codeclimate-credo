#!/usr/bin/env elixirc

{out, _exit} = System.cmd("mix", ~w[credo --format=json], stderr_to_stdout: true)

Jason.decode!(out)
|> IO.puts
