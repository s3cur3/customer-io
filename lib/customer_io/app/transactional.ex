defmodule CustomerIo.App.Transactional do
  @moduledoc """
  Provides API endpoints related to transactional
  """

  @default_client CustomerIo.App.Client

  @doc """
  Get a transactional message

  Returns information about an individual transactional message.
  """
  @spec get_transactional(integer, keyword) :: {:ok, map} | :error
  def get_transactional(transactional_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [transactional_id: transactional_id],
      call: {CustomerIo.App.Transactional, :get_transactional},
      url: "/v1/transactional/#{transactional_id}",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List transactional messages

  Returns a list of your transactional messages—the transactional IDs that you use to trigger an individual transactional delivery. This endpoint does not return information about deliveries (instances of a message sent to a person) themselves.
  """
  @spec list_transactional(keyword) :: {:ok, map} | :error
  def list_transactional(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.App.Transactional, :list_transactional},
      url: "/v1/transactional",
      method: :get,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get transactional message link metrics

  Returns metrics for clicked links from a transactional message, both in total and in `series` periods (days, weeks, etc). `series` metrics are ordered oldest to newest (i.e. the 0-index for any result is the oldest step/period).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.
    * `unique`: If true, the response contains only unique customer results, i.e. a customer who clicks a link twice is only counted once. If false, the response contains the total number of results without regard to uniqueness.

  """
  @spec transactional_links(integer, keyword) :: {:ok, map} | :error
  def transactional_links(transactional_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps, :unique])

    client.request(%{
      args: [transactional_id: transactional_id],
      call: {CustomerIo.App.Transactional, :transactional_links},
      url: "/v1/transactional/#{transactional_id}/metrics/links",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get transactional message deliveries

  Returns information about the deliveries (instances of messages sent to individual people) from a transactional message. Provide query parameters to refine the metrics you want to return.

  Use the `start_ts` and `end_ts` to find messages within a time range. If your request doesn't include `start_ts` and `end_ts` parameters, we'll return the most recent 6 months of messages. If your `start_ts` and `end_ts` range is more than 12 months, we'll return 12 months of data from the most recent timestamp in your request.


  ## Options

    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.
    * `limit`: The maximum number of results you want to retrieve per page.
    * `metric`: Determines the metric(s) you want to return.
    * `state`: The state of a broadcast.
    * `start_ts`: The beginning timestamp for your query.
    * `end_ts`: The ending timestamp for your query.

  """
  @spec transactional_messages(integer, keyword) :: {:ok, map} | :error
  def transactional_messages(transactional_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:end_ts, :limit, :metric, :start, :start_ts, :state])

    client.request(%{
      args: [transactional_id: transactional_id],
      call: {CustomerIo.App.Transactional, :transactional_messages},
      url: "/v1/transactional/#{transactional_id}/messages",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get transactional message metrics

  Returns a list of metrics for a transactional message in `steps` (days, weeks, etc). We return metrics from oldest to newest (i.e. the 0-index for any result is the oldest step/period).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.

  """
  @spec transactional_metrics(integer, keyword) :: {:ok, map} | :error
  def transactional_metrics(transactional_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps])

    client.request(%{
      args: [transactional_id: transactional_id],
      call: {CustomerIo.App.Transactional, :transactional_metrics},
      url: "/v1/transactional/#{transactional_id}/metrics",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Update the content of a transactional message

  Update a the body of a transactional email. This fully overwrites your existing transactional message. We'll use your updated content for any future transactional requests (`/v1/send/email`), so make sure that you test your message before you update it.

  """
  @spec update_transactional(integer, integer, map, keyword) :: {:ok, map} | {:error, map}
  def update_transactional(transactional_id, content_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [transactional_id: transactional_id, content_id: content_id, body: body],
      call: {CustomerIo.App.Transactional, :update_transactional},
      url: "/v1/transactional/#{transactional_id}/content/#{content_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :map}, {400, :map}, {404, :null}],
      opts: opts
    })
  end
end
