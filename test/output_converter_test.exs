defmodule Test.OutputConverter do
  use ExUnit.Case

  alias CodeclimateCredo.OutputConverter

  @input "[R] → web/test.ex:1:11 Modules should have a @moduledoc tag."

  @output "{\"type\":\"Issue\",\"location\":{\"path\":\"web/test.ex\",\"lines\":{\"end\":1,\"begin\":1}},\"description\":\"Modules should have a @moduledoc tag.\",\"check_name\":\"Code Readability\",\"categories\":[\"Style\"]}"

  test "convert one line input" do
    assert OutputConverter.convert({@input, true}) == @output
  end

  @input ~s"""
  [R] → web/test.exs:1:11 Modules should have a @moduledoc tag.
  [F] → web/test.exs:44 Pipe chain should start with a raw value.
  [C] ↗ web/test.exs:87 There is no whitespace around parentheses/brackets most of the time, but here there is.
  """

  @output "{\"type\":\"Issue\",\"location\":{\"path\":\"web/test.exs\",\"lines\":{\"end\":1,\"begin\":1}},\"description\":\"Modules should have a @moduledoc tag.\",\"check_name\":\"Code Readability\",\"categories\":[\"Style\"]}\0{\"type\":\"Issue\",\"location\":{\"path\":\"web/test.exs\",\"lines\":{\"end\":44,\"begin\":44}},\"description\":\"Pipe chain should start with a raw value.\",\"check_name\":\"Refactoring Oportunities\",\"categories\":[\"Style\"]}\0{\"type\":\"Issue\",\"location\":{\"path\":\"web/test.exs\",\"lines\":{\"end\":87,\"begin\":87}},\"description\":\"There is no whitespace around parentheses/brackets most of the time, but here there is.\",\"check_name\":\"Consistency\",\"categories\":[\"Style\"]}\0"

  test "convert multi line input" do
    assert OutputConverter.convert({@input, true}) == @output
  end

end
