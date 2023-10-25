defmodule CustomerIo.Exports do
  @moduledoc """
  Provides API endpoints related to exports
  """

  @default_client CustomerIo.Client

  @doc """
  Download an export

  This endpoint returns a signed link to download an export. The link expires after 15 minutes.
  """
  @spec download_export(integer, keyword) :: {:ok, map} | :error
  def download_export(export_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [export_id: export_id],
      call: {CustomerIo.Exports, :download_export},
      url: "/v1/exports/#{export_id}/download",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Export information about deliveries

  Provide filters for the newsletter, campaign, or action you want to return delivery information from. This endpoint starts an export, but you cannot download your export from this endpoint. Use the `/exports/{export_id}` endpoint to download your export.

  Use the `start` and `end` to find messages within a time range. If your request doesn't include `start` and `end` parameters, we'll return the most recent 6 months of messages. If your `start` and `end` range is more than 12 months, we'll return 12 months of data from the most recent timestamp in your request.

  """
  @spec export_deliveries_data(
          CustomerIo.Action.t()
          | CustomerIo.Campaign.t()
          | CustomerIo.Newsletter.t()
          | CustomerIo.TransactionalMessage.t(),
          keyword
        ) :: {:ok, map} | :error
  def export_deliveries_data(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {CustomerIo.Exports, :export_deliveries_data},
      url: "/v1/exports/deliveries",
      body: body,
      method: :post,
      request: [
        {"application/json",
         {:union,
          [
            {CustomerIo.Action, :t},
            {CustomerIo.Campaign, :t},
            {CustomerIo.Newsletter, :t},
            {CustomerIo.TransactionalMessage, :t}
          ]}}
      ],
      response: [{200, :map}, {400, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Export customer data

  Provide filters and attributes describing the customers you want to export. This endpoint returns export metadata; use the `/exports/{export_id}/endpoint` to download your export.
  """
  @spec export_people_data(map, keyword) :: {:ok, map} | :error
  def export_people_data(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {CustomerIo.Exports, :export_people_data},
      url: "/v1/exports/customers",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, {400, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get an export

  Return information about a specific export.
  """
  @spec get_export(integer, keyword) :: {:ok, map} | :error
  def get_export(export_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [export_id: export_id],
      call: {CustomerIo.Exports, :get_export},
      url: "/v1/exports/#{export_id}",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List exports

  Return a list of your exports. Exports are point-in-time people or campaign metrics.
  """
  @spec list_exports(keyword) :: {:ok, map} | :error
  def list_exports(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.Exports, :list_exports},
      url: "/v1/exports",
      method: :get,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end
end
