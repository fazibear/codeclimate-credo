defmodule Codeclimate.CLI do
  @moduledoc """
  Credo.CLI is the entrypoint for both the Mix task and the escript.
  It takes the parameters passed from the command line and translates them into
  a Command module (see the `Credo.CLI.Command` namespace), the work directory
  where the Command should run and a `Credo.Execution` struct.
  """

  alias Credo.Execution
  alias Codeclimate.Command
  alias Credo.Execution.Task

  @config_file "/config.json"

  @doc false
  def main(_argv) do
    Credo.start nil, nil

    %Execution{argv: []}
    |> Task.ParseOptions.call(nil)
    |> Task.ValidateOptions.call(nil)
    |> Task.ConvertCLIOptionsToConfig.call(nil)
    |> Task.ValidateConfig.call(nil)
    |> Task.UseColors.call(nil)
    |> Task.RequireRequires.call(nil)
    |> set_include_paths(load_json_config())
    |> Command.run()
  end

  defp load_json_config do
    case File.read @config_file do
      {:ok, config} -> config |> Poison.decode!
      _ -> %{}
    end
  end

  defp set_include_paths(%Execution{files: %{included: ["/code/**/*.{ex,exs}"]}} = exec, %{"include_paths" => paths}) when is_list(paths) do
    update_include_paths(exec, paths)
  end

  defp set_include_paths(%Execution{files: %{included: ["/code/lib" <> _, "/code/src" <> _, "/code/web" <> _, "/code/apps" <> _]}} = exec, %{"include_paths" => paths}) when is_list(paths) do
      update_include_paths(exec, paths)
  end

  defp set_include_paths(exec, _), do: exec

  defp update_include_paths(exec, paths) do
    paths = paths
            |> List.delete("deps/")
            |> List.delete("build/")
            |> Enum.map(fn (path) ->
              if path |> String.ends_with?("/") do
                "#{path}**/*.{ex,exs}"
              else
                if ~r/\.ex|\.exs$/ |> Regex.match?(path) do
                  path
                end
              end
            end)
            |> Enum.reject(&(!&1))

    %Execution{exec | files: %{ exec.files | included: paths } }
  end
end
