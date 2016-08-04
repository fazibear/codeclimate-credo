defmodule CodeclimateCredo.ConfigConverter do
  @moduledoc """
  Convert codeclimate config file to .credo.exs.

  Credo only support this file inside project. So you can create it manualy.
  Right now it's not working.
  """

  @cc_config_file "/config.json"
  @credo_config_file ".credo.exs"

  def convert do
    case parse_config do
      nil -> nil
      config ->
        config
        |> generate_config
    end
  end

  defp parse_config do
    case File.read(@cc_config_file) do
      {:ok, config} ->
        config
        |> Poison.decode!
      {:error, _} ->
        nil
    end
  end

  defp generate_config(config) do
    {:ok, file} = File.open(@credo_config_file, [:write])

    content = config
              |> config_hash
              |> hash_to_string

    file
    |> IO.binwrite(content)
    |> File.close
  end

  defp config_hash(config) do
    %{
      configs: [
        %{
          files: %{
            included: config["include_paths"],
            excluded: config["exclude_paths"]
          }
        }
      ]
    }
  end

  defp hash_to_string(hash) do
    opts = Inspect.Opts |> struct([])
    hash
    |> Inspect.Algebra.to_doc(opts)
    |> Inspect.Algebra.format(opts.width)
  end
end
