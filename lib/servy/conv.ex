defmodule Servy.Conv do
  @type t :: %__MODULE__{
          method: String.t(),
          params: map(),
          headers: map(),
          resp_body: String.t(),
          resp_content_type: String.t(),
          status: pos_integer()
        }

  defstruct method: "",
            path: "",
            params: %{},
            headers: %{},
            resp_body: "",
            resp_content_type: "text/html; charset=UTF-8",
            status: nil

  def full_status(conv) do
    "#{conv.status} #{status_reason(conv.status)}"
  end

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end
end
