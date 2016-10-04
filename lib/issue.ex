defmodule Codeclimate.Issue do
  @codeclimate_categories [
    "Bug Risk",
    "Clarity",
    "Compatibility",
    "Complexity",
    "Duplication",
    "Performance",
    "Security",
    "Style",
  ]

  @issues %{
    Credo.Check.Consistency.ExceptionNames => %{
      categories: ["Style"],
      description: """
      Exception names should end with a common suffix like "Error".

      Try to name your exception modules consistently:

          defmodule BadCodeError do
            defexception [:message]
          end

          defmodule ParserError do
            defexception [:message]
          end

      Inconsistent use should be avoided:

          defmodule BadHTTPResponse do
            defexception [:message]
          end

          defmodule HTTPHeaderException do
            defexception [:message]
          end

      While this is not necessarily a concern for the correctness of your code,
      you should use a consistent style throughout your codebase.
      """
    },
    Credo.Check.Consistency.LineEndings => %{
      categories: ["Style"],
      description: """
      Windows and *nix systems use different line-endings in files.

      While this is not necessarily a concern for the correctness of your code,
      you should use a consistent style throughout your codebase.
      """
    },
    Credo.Check.Consistency.SpaceAroundOperators => %{
      categories: ["Style"],
      description: """
      Use spaces around operators like `+`, `-`, `*` and `/`. This is the
      **preferred** way, although other styles are possible, as long as it is
      applied consistently.

          # preferred way
          1 + 2 * 4

          # also okay
          1+2*4

      While this is not necessarily a concern for the correctness of your code,
      you should use a consistent style throughout your codebase.
      """
    },
    Credo.Check.Consistency.SpaceInParentheses => %{
      categories: ["Style"],
      description: """
      Don't use spaces after `(`, `[`, and `{` or before `}`, `]`, and `)`. This is
      the **preferred** way, although other styles are possible, as long as it is
      applied consistently.

          # preferred way
          Helper.format({1, true, 2}, :my_atom)

          # also okay
          Helper.format( { 1, true, 2 }, :my_atom )

      While this is not necessarily a concern for the correctness of your code,
      you should use a consistent style throughout your codebase.
      """
    },
    Credo.Check.Consistency.TabsOrSpaces => %{
      categories: ["Style"],
      description: """
      Tabs should be used consistently.

      NOTE: This check does not verify the indentation depth, but checks whether
      or not soft/hard tabs are used consistently across all source files.

      It is very common to use 2 spaces wide soft-tabs, but that is not a strict
      requirement and you can use hard-tabs if you like that better.

      While this is not necessarily a concern for the correctness of your code,
      you should use a consistent style throughout your codebase.
      """
    },
    Credo.Check.Design.AliasUsage => %{
      categories: ["Style"],
      description: """
      Functions from other modules should be used via an alias if the module's
      namespace is not top-level.

      While this is completely fine:

          defmodule MyApp.Web.Search do
            def twitter_mentions do
              MyApp.External.TwitterAPI.search(...)
            end
          end

      ... you might want to refactor it to look like this:

          defmodule MyApp.Web.Search do
            alias MyApp.External.TwitterAPI

            def twitter_mentions do
              TwitterAPI.search(...)
            end
          end

      The thinking behind this is that you can see the dependencies of your module
      at a glance. So if you are attempting to build a medium to large project,
      this can help you to get your boundaries/layers/contracts right.

      Like all `Software Design` issues, this is just advice and might not be
      applicable to your project/situation.
      """
    },
    Credo.Check.Design.DuplicatedCode => %{
      categories: ["Duplication"],
      description: """
      Code should not be copy-pasted in a codebase when there is room to abstract
      the copied functionality in a meaningful way.

      That said, you should by no means "ABSTRACT ALL THE THINGS!".

      Sometimes it can serve a purpose to have code be explicit in two places, even
      if it means the snippets are nearly identical. A good example for this are
      Database Adapters in a project like Ecto, where you might have nearly
      identical functions for things like `order_by` or `limit` in both the
      Postgres and MySQL adapters.

      In this case, introducing an `AbstractAdapter` just to avoid code duplication
      might cause more trouble down the line than having a bit of duplicated code.

      Like all `Software Design` issues, this is just advice and might not be
      applicable to your project/situation.
      """
    },
    Credo.Check.Design.TagTODO => %{
      categories: ["Style"],
      description: """
      TODO comments are used to remind yourself of source code related things.

      Example:

          # TODO: move this to a Helper module
          defp fun do
            # ...
          end

      The premise here is that TODO should be dealt with in the near future and
      are therefore reported by Credo.

      Like all `Software Design` issues, this is just advice and might not be
      applicable to your project/situation.
      """
    },
    Credo.Check.Design.TagFIXME => %{
      categories: ["Style"],
      description: """
      FIXME comments are used to indicate places where source code needs fixing.

      Example:

          # FIXME: this does no longer work, research new API url
          defp fun do
            # ...
          end

      The premise here is that FIXME should indeed be fixed as soon as possible and
      are therefore reported by Credo.

      Like all `Software Design` issues, this is just advice and might not be
      applicable to your project/situation.
      """
    },
    Credo.Check.Readability.FunctionNames => %{
      categories: ["Style"],
      description: """
      Function and macro names are always written in snake_case in Elixir.

          # snake_case:

          def handle_incoming_message(message) do
          end

          # not snake_case

          def handleIncomingMessage(message) do
          end

      Like all `Readability` issues, this one is not a technical concern.
      But you can improve the odds of others reading and liking your code by making
      it easier to follow.
      """
    },
    Credo.Check.Readability.LargeNumbers => %{
      categories: ["Style"],
      description: """
      Numbers can contain underscores for readability purposes.
      These do not affect the value of the number, but can help read large numbers
      more easily.

          141592654 # how large is this number?

          141_592_654 # ah, it's in the hundreds of millions!

      Like all `Readability` issues, this one is not a technical concern.
      But you can improve the odds of others reading and liking your code by making
      it easier to follow.
      """
    },
    Credo.Check.Readability.MaxLineLength => %{
      categories: ["Style"],
      description: """
      Checks for the length of lines.

      Ignores function definitions and (multi-)line strings by default.
      """
    },
    Credo.Check.Readability.ModuleAttributeNames => %{
      categories: ["Style"],
      description: """
      Module attribute names are always written in snake_case in Elixir.

          # snake_case:

          @inbox_name "incoming"

          # not snake_case

          @inboxName "incoming"

      Like all `Readability` issues, this one is not a technical concern.
      But you can improve the odds of others reading and liking your code by making
      it easier to follow.
      """
    },
    Credo.Check.Readability.ModuleDoc => %{
      categories: ["Clarity"],
      description: """
      Every module should contain comprehensive documentation.

      Many times a sentence or two in plain english, explaining why the module
      exists, will suffice. Documenting your train of thought this way will help
      both your co-workers and your future-self.

      Other times you will want to elaborate even further and show some
      examples of how the module's functions can and should be used.

      In some cases however, you might not want to document things about a module,
      e.g. it is part of a private API inside your project. Since Elixir prefers
      explicitness over implicit behaviour, you should "tag" these modules with

          @moduledoc false

      to make it clear that there is no intention in documenting it.
      """
    },
    Credo.Check.Readability.ModuleNames => %{
      categories: ["Clarity"],
      description: """
      Module names are always written in PascalCase in Elixir.

          # PascalCase

          defmodule MyApp.WebSearchController do
            # ...
          end

          # not PascalCase

          defmodule MyApp.Web_searchController do
            # ...
          end

      Like all `Readability` issues, this one is not a technical concern.
      But you can improve the odds of other reading and liking your code by making
      it easier to follow.
      """
    },
    Credo.Check.Readability.ParenthesesInCondition => %{
      categories: ["Style"],
      description: """
      Because `if` and `unless` are macros, the preferred style is to not use
      parentheses around conditions.

          # preferred way
          if valid?(username) do
            # ...
          end

          # NOT okay
          if( valid?(username) ) do
            # ...
          end

      Like all `Readability` issues, this one is not a technical concern.
      But you can improve the odds of others reading and liking your code by making
      it easier to follow.
      """
    },
    Credo.Check.Readability.PredicateFunctionNames => %{
      categories: ["Style"],
      description: """
      Predicate functions/macros should be named accordingly:

      * For functions, they should end in a question mark.

          # okay

          defp user?(cookie) do
          end

          defp has_attachment?(mail) do
          end

          # not okay

          defp is_user?(cookie) do
          end

          defp is_user(cookie) do
          end

      * For guard-safe macros they should have the prefix `is_` and not end in a question mark.

      Like all `Readability` issues, this one is not a technical concern.
      But you can improve the odds of others reading and liking your code by making
      it easier to follow.
      """
    },
    Credo.Check.Readability.TrailingBlankLine => %{
      categories: ["Style"],
      description: """
      Files should end in a trailing blank line. Many editors ensure this
      "final newline" automatically.
      """
    },
    Credo.Check.Readability.TrailingWhiteSpace => %{
      categories: ["Style"],
      description: """
      There should be no white-space (i.e. tabs, spaces) at the end of a line.
      """
    },
    Credo.Check.Readability.VariableNames => %{
      categories: ["Style"],
      description: """
      Variable names are always written in snake_case in Elixir.

          # snake_case:

          incoming_result = handle_incoming_message(message)

          # not snake_case

          incomingResult = handle_incoming_message(message)

      Like all `Readability` issues, this one is not a technical concern.
      But you can improve the odds of others reading and liking your code by making
      it easier to follow.
      """
    },

    Credo.Check.Refactor.ABCSize => %{
      categories: ["Complexity"],
      description: """
      The ABC size describes a metric based on assignments, branches and conditions.

      A high ABC size is a hint that a function might be doing "more" than it
      should.

      As always: Take any metric with a grain of salt. Since this one was originally
      introduced for C, C++ and Java, we still have to see whether or not this can
      be a useful metric in a declarative language like Elixir.
      """
    },
    Credo.Check.Refactor.CondStatements => %{
      categories: ["Style"],
      description: """
      Each cond statement should have 3 or more statements including the
      "always true" statement. Otherwise an `if` and `else` construct might be more
      appropriate.

      Example:

        cond do
          x == y -> 0
          true -> 1
        end

        # should be written as

        if x == y do
          0
        else
          1
        end
      """
    },
    Credo.Check.Refactor.FunctionArity => %{
      categories: ["Style"],
      description: """
      A function can take as many parameters as needed, but even in a functional
      language there can be too many parameters.
      """
    },
    Credo.Check.Refactor.MatchInCondition => %{
      categories: ["Style"],
      description: """
      Pattern matching should only ever be used for simple assignments
      inside `if` and `unless` clauses.

      While this fine:

          # okay, simple wildcard assignment:

          if contents = File.read!("foo.txt") do
            do_something
          end

      the following should be avoided, since it mixes a pattern match with a
      condition and do/else blocks.

          # considered too "complex":

          if {:ok, contents} = File.read("foo.txt") do
            do_something
          end

          # also considered "complex":

          if allowed? && ( contents = File.read!("foo.txt") ) do
            do_something
          end

      If you want to match for something and execute another block otherwise,
      consider using a `case` statement:

          case File.read("foo.txt") do
            {:ok, contents} -> do_something
            _ -> do_something_else
          end
      """
    },
    Credo.Check.Refactor.PipeChainStart => %{
      categories: ["Style"],
      description: """
      Checks that each pipe chains start with a "raw" value for better readability.
      """
    },
    Credo.Check.Refactor.CyclomaticComplexity => %{
      categories: ["Complexity"],
      description: """
      Cyclomatic complexity is a software complexity metric closely correlated with
      coding errors.

      If a function feels like it's gotten too complex, it more often than not also
      has a high CC value. So, if anything, this is useful to convince team members
      and bosses of a need to refactor parts of the code based on "objective"
      metrics.
      """
    },
    Credo.Check.Refactor.NegatedConditionsInUnless => %{
      categories: ["Style"],
      description: """
      Unless blocks should not contain a negated condition.

      The code in this example ...

          unless !allowed? do
            proceed_as_planned
          end

      ... should be refactored to look like this:

          if allowed? do
            proceed_as_planned
          end

      The reason for this is not a technical but a human one. It is pretty difficult
      to wrap your head around a block of code that is executed if a negated
      condition is NOT met. See what I mean?
      """
    },
    Credo.Check.Refactor.NegatedConditionsWithElse => %{
      categories: ["Style"],
      description: """
      An `if` block with a negated condition should not contain an else block.

      So while this is fine:

          if !allowed? do
            raise "Not allowed!"
          end

      The code in this example ...

          if !allowed? do
            raise "Not allowed!"
          else
            proceed_as_planned
          end

      ... should be refactored to look like this:

          if allowed? do
            proceed_as_planned
          else
            raise "Not allowed!"
          end

      The reason for this is not a technical but a human one. It is easier to wrap
      your head around a positive condition and then thinking "and else we do ...".

      In the above example raising the error in case something is not allowed
      might seem so important to put it first. But when you revisit this code a
      while later or have to introduce a colleague to it, you might be surprised
      how much clearer things get when the "happy path" comes first.
      """
    },
    Credo.Check.Refactor.Nesting => %{
      categories: ["Style"],
      description: """
      Code should not be nested more than once inside a function.

          defmodule CredoSampleModule do
            def some_function(parameter1, parameter2) do
              Enum.reduce(var1, list, fn({_hash, nodes}, list) ->
                filenames = nodes |> Enum.map(&(&1.filename))
                Enum.reduce(list, [], fn(item, acc) ->
                  if item.filename do
                    item               # <-- this is nested 3 levels deep
                  end
                  acc ++ [item]
                end)
              end)
            end
          end

      At this point it might be a good idea to refactor the code to separate the
      different loops and conditions.
      """
    },
    Credo.Check.Refactor.UnlessWithElse => %{
      categories: ["Style"],
      description: """
      An `unless` block should not contain an else block.

      So while this is fine:

          unless allowed? do
            raise "Not allowed!"
          end

      This should be refactored:

          unless allowed? do
            raise "Not allowed!"
          else
            proceed_as_planned
          end

      to look like this:

          if allowed? do
            proceed_as_planned
          else
            raise "Not allowed!"
          end

      The reason for this is not a technical but a human one. The `else` in this
      case will be executed when the condition is met, which is the opposite of
      what the wording seems to apply.
      """
    },
    Credo.Check.Warning.IExPry => %{
      categories: ["Style"],
      description: """
      While calls to IEx.pry might appear in some parts of production code,
      most calls to this function are added during debugging sessions.

      This check warns about those calls, because they might have been committed
      in error.
      """
    },
    Credo.Check.Warning.IoInspect => %{
      categories: ["Style"],
      description: """
      While calls to IO.inspect might appear in some parts of production code,
      most calls to this function are added during debugging sessions.

      This check warns about those calls, because they might have been committed
      in error.
      """
    },
    Credo.Check.Warning.NameRedeclarationByAssignment => %{
      categories: ["Style"],
      description: """
      The names of local variables should not be the same as names of functions
      or macros in the same module or in `Kernel`.

        Example:

            def handle_something do
              time = 42
              IO.puts time  # not clear if we are talking about time/0 or time
            end

            def time do
              TimeHelper.now
            end

      This might not seem like a big deal, especially for small functions.
      But there is no downside to avoiding it, especially in the case of functions
      with arity `/0` and Kernel functions.

      True story: You might pattern match on a parameter geniusly called `node`.
      Then you remove that match for some reason and rename the parameter to `_node`
      because it is no longer used.
      Later you reintroduce the pattern match on `node` but forget to also rename
      `_node` and suddenly the match is actually against `Kernel.node/0` and has the
      weirdest side effects.
      """
    },
    Credo.Check.Warning.NameRedeclarationByCase => %{
      categories: ["Style"],
      description: """
      Names assigned to choices in a `case` statement should not be the same as
      names of functions in the same module or in `Kernel`.

      Example:

          def handle_something(foo, bar) do
            case foo do
              nil -> bar
              time ->
                Logger.debug "Request handled"
                time   # are we talking about time/0 or the value of foo here?
            end
          end

          def time do
            TimeHelper.now
          end

      This might not seem like a big deal, especially for small functions.
      But there is no downside to avoiding it, especially in the case of functions
      with arity `/0` and Kernel functions.

      True story: You might pattern match on a parameter geniusly called `node`.
      Then you remove that match for some reason and rename the parameter to `_node`
      because it is no longer used.
      Later you reintroduce the pattern match on `node` but forget to also rename
      `_node` and suddenly the match is actually against `Kernel.node/0` and has the
      weirdest side effects.
      """
    },
    Credo.Check.Warning.NameRedeclarationByDef => %{
      categories: ["Style"],
      description: """
      Names assigned to parameters of a named function should not be the same as
      names of functions in the same module or in `Kernel`.

      Example:

          def handle_something(date, time) do
            time  # not clear if we are talking about time/0 or time
          end

          def time do
            TimeHelper.now
          end

      This might not seem like a big deal, especially for small functions.
      But there is no downside to avoiding it, especially in the case of functions
      with arity `/0` and Kernel functions.

      True story: You might pattern match on a parameter geniusly called `node`.
      Then you remove that match for some reason and rename the parameter to `_node`
      because it is no longer used.
      Later you reintroduce the pattern match on `node` but forget to also rename
      `_node` and suddenly the match is actually against `Kernel.node/0` and has the
      weirdest side effects.
      """
    },
    Credo.Check.Warning.NameRedeclarationByFn => %{
      categories: ["Clarity"],
      description: """
      Names assigned to parameters of an anonymous function should not be the
      same as names of functions in the same module or in `Kernel`.

      Example:

          def handle_something(time_list) do
            time_list
            |> Enum.each(fn(time) ->   # not clear if talking about time/0 or time
                IO.puts time
              end)
          end

          def time do
            TimeHelper.now
          end

      This might not seem like a big deal, especially for small functions.
      But there is no downside to avoiding it, especially in the case of functions
      with arity `/0` and Kernel functions.

      True story: You might pattern match on a parameter geniusly called `node`.
      Then you remove that match for some reason and rename the parameter to `_node`
      because it is no longer used.
      Later you reintroduce the pattern match on `node` but forget to also rename
      `_node` and suddenly the match is actually against `Kernel.node/0` and has the
      weirdest side effects.
      """
    },
    Credo.Check.Warning.OperationOnSameValues => %{
      categories: ["Bug Risk"],
      description: """
      Operations on the same values always yield the same result and therefore make
      little sense in production code.

      Examples:

          x == x  # always returns true
          x <= x  # always returns true
          x >= x  # always returns true
          x != x  # always returns false
          x > x   # always returns false
          y / y   # always returns 1
          y - y   # always returns 0

      In pratice they are likely the result of a debugging session or were made by
      mistake.
      """
    },
    Credo.Check.Warning.BoolOperationOnSameValues => %{
      categories: ["Bug Risk"],
      description: """
      Boolean operations with identical values on the left and right side are
      most probably a logical fallacy or a copy-and-paste error.

      Examples:

          x && x
          x || x
          x and x
          x or x

      Each of these cases behaves the same as if you were just writing `x`.
      """
    },
    Credo.Check.Warning.UnusedEnumOperation => %{
      categories: ["Bug Risk"],
      description: """
      With the exception of `Enum.each/2`, the result of a call to the
      Enum module's functions has to be used.

      While this is correct ...

          def prepend_my_username(my_username, usernames) do
            valid_usernames = Enum.reject(usernames, &is_nil/1)
            [my_username] ++ valid_usernames
          end

      ... we forgot to save the downcased username in this example:

          # This is bad because it does not modify the usernames variable!
          def prepend_my_username(my_username, usernames) do
            Enum.reject(usernames, &is_nil/1)
            [my_username] ++ valid_usernames
          end

      Since Elixir variables are immutable, Enum operations never work on the
      variable you pass in, but return a new variable which has to be used somehow
      (the exception being `Enum.each/2` which iterates a list and returns `:ok`).
      """
    },
    Credo.Check.Warning.UnusedKeywordOperation => %{
      categories: ["Bug Risk"],
      description: """
      The result of a call to the Keyword module's functions has to be used.

      Keyword operations never work on the variable you pass in, but return a new
      variable which has to be used somehow.
      """
    },
    Credo.Check.Warning.UnusedListOperation => %{
      categories: ["Bug Risk"],
      description: """
      The result of a call to the List module's functions has to be used.

      List operations never work on the variable you pass in, but return a new
      variable which has to be used somehow.
      """
    },
    Credo.Check.Warning.UnusedStringOperation => %{
      categories: ["Bug Risk"],
      description: """
      The result of a call to the String module's functions has to be used.

      While this is correct ...

          def salutation(username) do
            username = String.downcase(username)
            "Hi #\{username}"
          end

      ... we forgot to save the downcased username in this example:

          # This is bad because it does not modify the username variable!
          def salutation(username) do
            String.downcase(username)
            "Hi #\{username}"
          end

      Since Elixir variables are immutable, String operations never work on the
      variable you pass in, but return a new variable which has to be used somehow.
      """
    },
    Credo.Check.Warning.UnusedTupleOperation => %{
      categories: ["Bug Risk"],
      description: """
      The result of a call to the Tuple module's functions has to be used.

      Tuple operations never work on the variable you pass in, but return a new
      variable which has to be used somehow.
      """
    },
    Credo.Check.Warning.OperationWithConstantResult => %{
      categories: ["Bug Risk"],
      description: """
      Operations on the same values always yield the same result and therefore make
      little sense in production code.

      Examples:

      x * 1   # always returns x
      x * 0   # always returns 0

      In pratice they are likely the result of a debugging session or were made by
      mistake.
      """
    }
  }

  def categories(issue) do
    @issues[issue][:categories]
  end

  def description(issue) do
    @issues[issue][:description]
  end

  def all do
    Map.keys(@issues)
  end

  def codeclimate_categories do
    @codeclimate_categories
  end

  def check_name(issue) do
    issue
    |> Module.split
    |> List.last
    |> Macro.underscore
    |> String.replace("_", " ")
    |> String.capitalize
  end
end
