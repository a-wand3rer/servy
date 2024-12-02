defmodule Servy.BearController do
  alias Servy.Bear
  def index(conv) do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def show(conv, id) do
    %{conv | status: 200, resp_body: "Bear #{id}"}
  end

  def get_bears(conv) do
    items = Bear.list()
    |> Enum.filter(&Bear.is_hibernating/1)
    |> Enum.sort(&Bear.sort_by_id_asc/2)
    |> Enum.map(&to_item/1)
    |> Enum.join()

    %{conv | status: 200, resp_body: "<ul>#{items}</ul>"}
  end

  defp to_item(%Bear{name: name, id: id}) do
    "<li>ID: #{id} | Name: #{name} </li>"
  end
end
