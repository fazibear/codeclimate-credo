defmodule Codeclimate.Formatter do
  alias Credo.CLI.Filter
  alias Codeclimate.Issue

  @doc "Called before the analysis is run."
  def print_before_info(source_files, _config) do
    case Enum.count(source_files) do
      0 -> error("No files found!")
      1 -> error("Checking 1 source file ...")
      count -> error("Checking #{count} source files...")
    end
  end

  @doc "Called after the analysis has run."
  def print_after_info(source_files, config, time_load, time_run) do
    issues = source_files |> Enum.flat_map(&(&1.issues))

    issues
    |> Filter.important(config)
    |> Filter.valid_issues(config)
    |> Enum.map(&json/1)
    |> Enum.join("\0")
    |> print

    error("Finished! (#{format_in_seconds(time_load)}s to load, #{format_in_seconds(time_run)}s running checks)")
  end

  defp json(issue) do
    %{
      type: "Issue",
      categories: Issue.categories(issue.check),
      check_name: Issue.check_name(issue.check),
      description: issue.message,
      remediation_points: 100_000,
      content: %{
        body: Issue.description(issue.check)
      },
      location: %{
        path: issue.filename,
        lines: %{
          begin: issue.line_no || 1,
          end: issue.line_no || 1
        }
      }
    } |> Poison.encode!
  end

  defp format_in_seconds(t) do
    t = t |> div(10_000)

    if t < 10 do
      "0.0#{t}"
    else
      t = div t, 10
      "#{div(t, 10)}.#{rem(t, 10)}"
    end
  end

  defp error(str), do: IO.puts(:stderr, str)
  defp print(str), do: IO.puts(str)
end
