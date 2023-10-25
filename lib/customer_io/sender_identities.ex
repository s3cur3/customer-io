defmodule CustomerIo.SenderIdentities do
  @moduledoc """
  Provides API endpoints related to sender identities
  """

  @default_client CustomerIo.Client

  @doc """
  Get a sender

  Returns information about a specific sender.
  """
  @spec get_sender(integer, keyword) :: {:ok, map} | :error
  def get_sender(sender_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [sender_id: sender_id],
      call: {CustomerIo.SenderIdentities, :get_sender},
      url: "/v1/sender_identities/#{sender_id}",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get sender usage data

  Returns lists of the campaigns and newsletters that use a sender.
  """
  @spec get_sender_usage(integer, keyword) :: {:ok, map} | :error
  def get_sender_usage(sender_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [sender_id: sender_id],
      call: {CustomerIo.SenderIdentities, :get_sender_usage},
      url: "/v1/sender_identities/#{sender_id}/used_by",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List sender identities

  Returns a list of senders in your workspace. Senders are who your messages are "from".

  ## Options

    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.
    * `limit`: The maximum number of results you want to retrieve per page.
    * `sort`: Determine how you want to sort results, `asc` for chronological order and `desc` for reverse chronological order.

  """
  @spec list_senders(keyword) :: {:ok, map} | :error
  def list_senders(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:limit, :sort, :start])

    client.request(%{
      args: [],
      call: {CustomerIo.SenderIdentities, :list_senders},
      url: "/v1/sender_identities",
      method: :get,
      query: query,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end
end
