defmodule Servy.Server do
  alias Servy.Handler

  def start(port) do
    {:ok, listening_socket} =
      :gen_tcp.listen(port, [
        :binary,
        packet: :raw,
        active: false,
        reuseaddr: true
      ])

    IO.puts("Listening for incoming traffic on port #{port}")

    spawn(fn -> loop(listening_socket) end)
  end

  defp loop(listening_socket) do
    # this is a block call
    {:ok, client_socket} = :gen_tcp.accept(listening_socket)

    IO.puts("#{inspect(self())} Connection accepted! ")
    pid = spawn(fn -> serve(client_socket) end)
    :gen_tcp.controlling_process(client_socket, pid)

    loop(listening_socket)
  end

  defp serve(client_socket) do
    IO.puts("Handling client socket in #{inspect(self())}")

    client_socket
    |> read_request
    # |> Servy.Parser.parse()
    # |> generate_response
    |> dbg()
    |> Handler.handle()
    |> dbg()
    |> write_response(client_socket)
  end

  defp read_request(client_socket) do
    {:ok, request} = :gen_tcp.recv(client_socket, 0)

    IO.puts("=> Received request: \n")
    IO.puts(request)

    request
  end

  defp write_response(response, client_socket) do
    :ok = :gen_tcp.send(client_socket, response)

    IO.puts("<== Sent response \n")
    IO.puts(response)

    :gen_tcp.close(client_socket)
  end
end
