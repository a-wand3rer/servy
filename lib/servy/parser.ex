defmodule Servy.Parser do
  alias Servy.Conv

  @spec parse(String.t()) :: Servy.Conv.t()
  def parse(request) do
    [top, params_string] = String.split(request, "\r\n\r\n")
    [request_line | header_lines] = String.split(top, "\r\n")
    [method, path, _] = String.split(request_line, " ")
    headers = parse_headers(header_lines, %{})
    params = parse_params(headers["Content-Type"], params_string)

    %Conv{
      method: method,
      path: path,
      params: params,
      headers: headers
    }
  end

  def parse_headers([], headers), do: headers

  def parse_headers([head | tail], headers) do
    [name, value] = String.split(head, ": ")
    headers = Map.put(headers, name, value)
    parse_headers(tail, headers)
  end

  @doc """
    iex> params_str = "name=John&age=30"
    iex> parsed = Servy.Parser.parse_params("application/x-www-form-urlencoded", params_str)
    %{"name" => "John", "age" => "30"}
  """
  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

  def parse_params(_, _) do
    %{}
  end
end
