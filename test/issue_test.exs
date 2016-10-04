defmodule Test.Reporter do
  use ExUnit.Case
  alias Codeclimate.Issue

  test "all issues should includes correct categories" do
    Issue.all
    |> Enum.each(fn(issue) ->
        issue
        |> Issue.categories
        |> Enum.each(fn(category) ->
          assert Issue.codeclimate_categories
          |> Enum.member?(category)
        end)
    end)
  end
end
