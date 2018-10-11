defmodule CodeclimateTest do
  use ExUnit.Case
  doctest Codeclimate

  test "greets the world" do
    assert Codeclimate.hello() == :world
  end
end
