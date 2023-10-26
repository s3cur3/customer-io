defmodule CustomerIo.App.ReportingWebhooks do
  @moduledoc """
  Provides API endpoints related to reporting webhooks
  """

  @default_client CustomerIo.App.Client

  @doc """
  Create a reporting webhook

  Create a new webhook configuration.
  """
  @spec create_webhook(map, keyword) :: {:ok, map} | :error
  def create_webhook(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {CustomerIo.App.ReportingWebhooks, :create_webhook},
      url: "/v1/reporting_webhooks",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, {400, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Delete a reporting webhook

  Delete a reporting webhook's configuration.
  """
  @spec delete_webhook(integer, keyword) :: :ok | :error
  def delete_webhook(webhook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [webhook_id: webhook_id],
      call: {CustomerIo.App.ReportingWebhooks, :delete_webhook},
      url: "/v1/reporting_webhooks/#{webhook_id}",
      method: :delete,
      response: [{200, :null}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get a reporting webhook

  Returns information about a specific reporting webhook.
  """
  @spec get_webhook(integer, keyword) :: {:ok, map} | :error
  def get_webhook(webhook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [webhook_id: webhook_id],
      call: {CustomerIo.App.ReportingWebhooks, :get_webhook},
      url: "/v1/reporting_webhooks/#{webhook_id}",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List reporting webhooks

  Return a list of all of your reporting webhooks
  """
  @spec list_webhooks(keyword) :: {:ok, map} | :error
  def list_webhooks(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.App.ReportingWebhooks, :list_webhooks},
      url: "/v1/reporting_webhooks",
      method: :get,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Update a webhook configuration

  Update the configuration of a reporting webhook. Turn events on or off, change the webhook URL, etc.
  """
  @spec update_webhook(integer, map, keyword) :: {:ok, map} | :error
  def update_webhook(webhook_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [webhook_id: webhook_id, body: body],
      call: {CustomerIo.App.ReportingWebhooks, :update_webhook},
      url: "/v1/reporting_webhooks/#{webhook_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :map}, {400, :null}, {404, :null}, {429, :null}],
      opts: opts
    })
  end
end
