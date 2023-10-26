defmodule CustomerIo.App.Messages do
  @moduledoc """
  Provides API endpoints related to messages
  """

  @default_client CustomerIo.App.Client

  @doc """
  Get an archived message

  Returns the archived copy of a delivery, including the message body, recipient, and metrics. This endpoint is limited to 100 requests per day.
  """
  @spec get_archived_message(String.t(), keyword) :: {:ok, map} | :error
  def get_archived_message(message_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [message_id: message_id],
      call: {CustomerIo.App.Messages, :get_archived_message},
      url: "/v1/messages/#{message_id}/archived_message",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get a message

  Return a information about, and metrics for, a delivery—the instance of a message intended for an individual recipient person.
  """
  @spec get_message(String.t(), keyword) :: {:ok, map} | :error
  def get_message(message_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [message_id: message_id],
      call: {CustomerIo.App.Messages, :get_message},
      url: "/v1/messages/#{message_id}",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List messages

  Return a list of deliveries, including metrics for each delivery, for messages in your workspace. The request body contains filters determining the deliveries you want to return information about.

  Use the `start_ts` and `end_ts` to find messages within a time range. If your request doesn't include `start_ts` and `end_ts` parameters, we'll return the most recent 6 months of deliveries.


  ## Options

    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.
    * `limit`: The maximum number of results you want to retrieve per page.
    * `type`: The type of item you want to return metrics for. When empty, the response contains metrics for all possible types.
    * `metric`: Determines the metric(s) you want to return.
    * `drafts`: If true, your request returns drafts rather than active/sent messages.
    * `campaign_id`: The campaign you want to filter for.
    * `newsletter_id`: The newsletter you want to filter for.
    * `action_id`: The action you want to filter for.
    * `start_ts`: The beginning timestamp for your query.
    * `end_ts`: The ending timestamp for your query.

  """
  @spec list_messages(keyword) :: {:ok, map} | :error
  def list_messages(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :action_id,
        :campaign_id,
        :drafts,
        :end_ts,
        :limit,
        :metric,
        :newsletter_id,
        :start,
        :start_ts,
        :type
      ])

    client.request(%{
      args: [],
      call: {CustomerIo.App.Messages, :list_messages},
      url: "/v1/messages",
      method: :get,
      query: query,
      response: [{200, :map}, {400, :null}, {429, :null}],
      opts: opts
    })
  end
end
