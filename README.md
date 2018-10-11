# Code Climate Credo Engine [![Build Status](https://travis-ci.org/fazibear/codeclimate-credo.svg?branch=master)](https://travis-ci.org/fazibear/codeclimate-credo)

Code Climate engine for [Credo](https://github.com/rrrene/credo) a static code analysis tool for the [Elixir Language](http://elixir-lang.org/).

## Configure

You can configure this engine with the following options in your `.codeclimate.yml` file:

```
engines:
  credo:
    enabled: true
    strict: true
    all: true
    only: "warning"
    ignore: "readability"
```

- `strict` - if you want to enforce a style guide and need a more traditional linting experience
- `all` - if you want to use all checkers
- `only` - run only a subset of checks
- `ignore` - ignore selected checks

For more information check [credo](https://github.com/rrrene/credo) repository.

## .credo.exs

You can configure this engine in `.credo.exs` file within your project. More informations is available [here](https://github.com/rrrene/credo#configuration).

## Thank you!

[![Become Patreon](https://c5.patreon.com/external/logo/become_a_patron_button.png)](https://www.patreon.com/bePatron?u=6912974)
