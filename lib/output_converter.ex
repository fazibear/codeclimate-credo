defmodule CodeclimateCredo.OutputConverter do
  @moduledoc """
  Convert credo output to codeclimate json.
  """

  def convert({out, _}) do
    out
    |> String.split("\n")
    |> Enum.map(fn (line) ->
         line
         |> String.split(" ")
         |> convert_line
       end)
    |> Enum.join("\0")
  end

  defp convert_line([type, _, file | error]) do
    case String.split(file, ":") do
      [file_name, line, _column] -> json(type, file_name, line, error)
      [file_name, line] -> json(type, file_name, line, error)
      _ -> nil
    end
  end
  defp convert_line(_), do: nil

  defp json(type, file_name, line, error) do
    %{
      type: "Issue",
      check_name: type(type),
      description: description(error),
      categories: category(type),
      location: %{
        path: path(file_name),
        lines: lines(line)
      }
    } |> Poison.encode!
  end

  defp description(error) do
    error
    |> Enum.join(" ")
  end

  defp type(type) do
    case type do
      "[R]" -> "Code Readability"
      "[F]" -> "Refactoring Oportunities"
      "[W]" -> "Warrning"
      "[C]" -> "Consistency"
      "[D]" -> "Software Design"
    end
  end

  defp category(type) do
    case type do
      "[R]" -> ["Style"]
      "[F]" -> ["Style"]
      "[W]" -> ["Bug Risk"]
      "[C]" -> ["Style"]
      "[D]" -> ["Style"]
    end
  end

  defp path(file_name) do
    file_name
    |> String.replace(~r/^\/code\//, "")
  end

  defp lines(line) do
    {iline, _} = Integer.parse(line)

    %{
      begin: iline,
      end: iline
    }
  end
end
