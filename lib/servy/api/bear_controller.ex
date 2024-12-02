defmodule Servy.Api.BearController do
  alias Servy.Bear

  def index(conv) do
    encoded = Poison.encode!(Bear.list())
    %{conv | status: 200, resp_body: encoded, resp_content_type: "application/json"}
  end
end
