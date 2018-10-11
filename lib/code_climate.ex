defmodule CodeClimate do
  @moduledoc """
  Documentation for Codeclimate.
  """

  @config_filename "/config.json"
  @cmd "mix"
  @default_opts ~w[credo --format=codeclimate]

  def main([path]) do
    {:ok, config} = open_config_file(@config_filename)

    opts = @default_opts ++ build_options_from_config(config, path) ++ [path]

    debug(opts)


    {out, _exit} = System.cmd(@cmd, opts, stderr_to_stdout: false)

    IO.puts(out)
  end

  defp open_config_file(filename) do
    with {:ok, body} <- File.read(filename), {:ok, json} <- Jason.decode(body), do: {:ok, json}
  end

  defp build_options_from_config(config, path) do
    []
    |> process_include_paths(config, path)
    |> process_exclude_paths(config, path)
    |> process_strict(config)
    |> process_all(config)
    |> process_only(config)
    |> process_ignore(config)
  end

  defp process_include_paths(opts, %{"include_paths" => include_paths}, path) do
    opts ++
      Enum.map(include_paths, fn include ->
        "--include=#{path}/#{include}"
      end)
  end

  defp process_include_paths(opts, _, _), do: opts

  defp process_exclude_paths(opts, %{"exclude_paths" => exclude_paths}, path) do
    opts ++
      Enum.map(exclude_paths, fn exlude ->
        "--exclude=#{path}/#{exlude}"
      end)
  end

  defp process_exclude_paths(opts, _, _), do: opts

  defp process_strict(opts, %{"strict" => true}), do: opts ++ ["--strict"]
  defp process_strict(opts, _), do: opts

  defp process_all(opts, %{"all" => true}), do: opts ++ ["--all"]
  defp process_all(opts, _), do: opts

  defp process_only(opts, %{"only" => only}), do: opts ++ ["--only=#{only}"]
  defp process_only(opts, _), do: opts

  defp process_ignore(opts, %{"ignore" => ignore}), do: opts ++ ["--ignore=#{ignore}"]
  defp process_ignore(opts, _), do: opts

  defp debug(input) do
    IO.puts(:stderr, inspect(input))
    input
  end
end
