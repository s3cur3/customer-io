defmodule CustomerIo.Info do
  @moduledoc """
  Provides API endpoint related to info
  """

  @default_client CustomerIo.Client

  @doc """
  List IP addresses

  Returns a list of IP addresses that you need to allowlist if you're using a firewall or [Custom SMTP](/docs/use-your-smtp-server) provider's IP access management settings to deny access to unknown IP addresses.

  These addresses apply to all message types and webhooks, except push notifications.

  """
  @spec get_cio_allowlist(keyword) :: {:ok, map} | :error
  def get_cio_allowlist(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.Info, :get_cio_allowlist},
      url: "/v1/info/ip_addresses",
      method: :get,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end
end
