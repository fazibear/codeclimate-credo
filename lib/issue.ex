defmodule Codeclimate.Issue do
  # @codeclimate_categories [
  #   "Bug Risk",
  #   "Clarity",
  #   "Compatibility",
  #   "Complexity",
  #   "Duplication",
  #   "Performance",
  #   "Security",
  #   "Style",
  # ]

  @issue_category %{
    Credo.Check.Design.DuplicatedCode => ["Duplication"],
    Credo.Check.Readability.ModuleDoc => ["Clarity"],
    Credo.Check.Readability.ModuleNames => ["Clarity"],
    Credo.Check.Refactor.ABCSize => ["Complexity"],
    Credo.Check.Refactor.CyclomaticComplexity => ["Complexity"],
    Credo.Check.Warning.NameRedeclarationByFn => ["Clarity"],
    Credo.Check.Warning.OperationOnSameValues => ["Bug Risk"],
    Credo.Check.Warning.BoolOperationOnSameValues => ["Bug Risk"],
    Credo.Check.Warning.UnusedEnumOperation => ["Bug Risk"],
    Credo.Check.Warning.UnusedKeywordOperation => ["Bug Risk"],
    Credo.Check.Warning.UnusedListOperation => ["Bug Risk"],
    Credo.Check.Warning.UnusedStringOperation => ["Bug Risk"],
    Credo.Check.Warning.UnusedTupleOperation => ["Bug Risk"],
    Credo.Check.Warning.OperationWithConstantResult => ["Bug Risk"],
  }

  defp categories(issue) do
    @issue_category[issue] || ["Style"]
  end

  defp check_name(issue) do
    issue
    |> Module.split
    |> List.last
    |> Macro.underscore
  end

  def json(issue) do
    %{
      type: "Issue",
      categories: categories(issue.check),
      check_name: check_name(issue.check),
      description: issue.message,
      remediation_points: 100_000,
      content: %{
        body: issue.check.explanation
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
end
