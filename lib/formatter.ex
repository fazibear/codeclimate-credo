defmodule Codeclimate.Formatter do
  alias Credo.CLI.Filter
  alias Codeclimate.Issue
  alias Credo.Execution

  @doc "Called before the analysis is run."
  def print_before_info(source_files, _exec) do
    case Enum.count(source_files) do
      0 -> debug("No files found!")
      1 -> debug("Checking 1 source file ...")
      count -> debug("Checking #{count} source files...")
    end
  end

  @doc "Called after the analysis has run."
  def print_after_info(_source_files, exec, time_load, time_run) do

    exec
    |> Execution.get_issues()
    |> Filter.important(exec)
    |> Filter.valid_issues(exec)
    |> Enum.map(&Issue.json/1)
    |> Enum.join("\0")
    |> print

    debug("Finished! (#{format_in_seconds(time_load)}s to load, #{format_in_seconds(time_run)}s running checks)")
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

  defp print(str), do: IO.puts(str)
  defp debug(str), do: IO.puts(:stderr, str)
end
