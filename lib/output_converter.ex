defmodule OutputConverter do
  def convert({out, _}) do
    out
    |> String.split("\n")
    |> Enum.map(fn (line) ->
         line
         |> String.split(" ")
         |> convert_line
       end)
    |> Enum.join("\0")
    |> IO.puts
  end

  defp convert_line([type, _, file | error]) do
    case String.split(file, ":") do
      [file_name, line, column] ->
        %{
          type: "Issue",
          check_name: type(type),
          description: description(error),
          categories: category(type),
          location: %{
            path: path(file_name),
            lines: lines(line, column)
          }
        } |> Poison.encode!
        _ -> nil
    end
  end

  defp convert_line(_), do: nil

  defp description(error) do
    error
    |> Enum.join(" ")
  end

  defp type(type) do
    case type do
      "[R]" -> "Refactoring Oportunities"
      "[W]" -> "Warrning"
      "[C]" -> "Consistency"
      "[D]" -> "Software Design"
    end
  end

  defp category(type) do
    case type do
      "[W]" -> ["Bug Risk"]
      "[C]" -> ["Style"]
      "[R]" -> ["Duplication"]
      "[D]" -> ["Style"]
    end
  end

  defp path(file_name) do
    file_name
    |> String.replace(~r/^\/code\//, "")
  end

  defp lines(line, _column) do
    {iline, _} = Integer.parse(line)

    %{
      begin: iline,
      end: iline
    }
  end
end
