defmodule Servy.ParserTest do
  use ExUnit.Case
  doctest Servy.Parser

  test "can parse post request" do
    req = """
    POST /bears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Content-Type: application/x-www-form-urlencoded
    Content-Length: 21

    name=Baloo&type=Brown
    """

    conv = Servy.Parser.parse(req)
    assert conv.method == "POST"
    assert conv.params == %{"name" => "Baloo", "type" => "Brown"}

    assert conv.headers == %{
             "User-Agent" => "ExampleBrowser/1.0",
             "Host" => "example.com",
             "Content-Type" => "application/x-www-form-urlencoded",
             "Content-Length" => "21"
           }
  end
end
