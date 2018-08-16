defmodule Elixium.P2P.GhostProtocol.Message do
  require IEx
  alias Elixium.Utilities

  @moduledoc """
    Create and read messages that are sent over TCP
  """

  @doc """
    Create an unencrypted message that will be passed to a peer, with the
    contents of message_map
  """
  @spec build(String.t(), map) :: String.t()
  def build(type, message_map) do
    message = binary_message(type, message_map)
    bytes = message_byte_size(message)

    ["Ghost", bytes, message]
    |> Enum.join("|")
  end

  @doc """
    Same as build/2 except the message is encrypted
  """
  @spec build(String.t(), map, <<_::256>>) :: String.t()
  def build(type, message_map, session_key) do
    message =
      type
      |> binary_message(message_map)
      |> Utilities.pad(32)

    encrypted_message = :crypto.block_encrypt(:aes_ecb, session_key, message)
    bytes = message_byte_size(encrypted_message)

    ["Ghost", bytes, encrypted_message]
    |> Enum.join("|")
  end

  @doc """
    Read a full unencrypted message from the socket
  """
  @spec read(reference) :: map | {:error, :invalid_protocol}
  def read(socket) do
    {protocol, bytes} = parse_header(socket)

    if protocol == "Ghost" do
      {:ok, data} =
        socket
        |> :gen_tcp.recv(bytes)

      :erlang.binary_to_term(data)
    else
      {:error, :invalid_protocol}
    end
  end

  @doc """
    Read a full encrypted message from the socket
  """
  @spec read(reference, <<_::256>>) :: map | {:error, :invalid_protocol}
  def read(socket, session_key) do
    {protocol, bytes} = parse_header(socket)

    if protocol == "Ghost" do
      {:ok, data} =
        socket
        |> :gen_tcp.recv(bytes)

      data
      |> decrypt(session_key)
    else
      {:error, :invalid_protocol}
    end
  end

  # Convert a message body to binary
  @spec binary_message(String.t(), map) :: binary
  defp binary_message(type, message) do
    message
    |> Map.merge(%{type: type})
    |> :erlang.term_to_binary()
  end

  @spec message_byte_size(String.t()) :: integer
  defp message_byte_size(message) do
    message
    |> byte_size()
    |> pad_bytes()
  end

  # Since message byte count must be specified as 8 bytes ("00000000"),
  # pad any integer with the necessary amount of 0's to make the length 8
  @spec pad_bytes(integer) :: String.t()
  defp pad_bytes(bytes) do
    bytes = Integer.to_string(bytes)
    num_zeros = 8 - byte_size(bytes)

    String.duplicate("0", num_zeros) <> bytes
  end

  # Read the head of a message, where the protocol type is specified, followed
  # by the length, in bytes, of the rest of the message
  @spec parse_header(reference) :: {String.t(), integer}
  defp parse_header(socket) do
    {:ok, header} =
      socket
      # Will get "Ghost|00000000|" from socket
      |> :gen_tcp.recv(15)

    [protocol, bytes, _] = String.split(header, "|")
    {bytes, _} = Integer.parse(bytes)

    {protocol, bytes}
  end

  @spec decrypt(bitstring, <<_::256>>) :: map
  defp decrypt(data, key) do
    :crypto.block_decrypt(:aes_ecb, key, data) |> :erlang.binary_to_term()
  end
end