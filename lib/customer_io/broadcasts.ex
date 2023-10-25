defmodule CustomerIo.Broadcasts do
  @moduledoc """
  Provides API endpoints related to broadcasts
  """

  @default_client CustomerIo.Client

  @doc """
  Get broadcast action link metrics

  Returns link click metrics for an individual broadcast action. Unless you specify otherwise, the response contains data for the maximum period by days (45 days).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.
    * `type`: The type of item you want to return metrics for. When empty, the response contains metrics for all possible types.

  """
  @spec broadcast_action_links(integer, integer, keyword) :: {:ok, map} | :error
  def broadcast_action_links(broadcast_id, action_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps, :type])

    client.request(%{
      args: [broadcast_id: broadcast_id, action_id: action_id],
      call: {CustomerIo.Broadcasts, :broadcast_action_links},
      url: "/v1/broadcasts/#{broadcast_id}/actions/#{action_id}/metrics/links",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get broadcast action metrics

  Returns a list of metrics for an individual action both in total and in `steps` (days, weeks, etc) over a period of time. Stepped `series` metrics return from oldest to newest (i.e. the 0-index for any result is the oldest step/period).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.
    * `type`: The type of item you want to return metrics for. When empty, the response contains metrics for all possible types.

  """
  @spec broadcast_action_metrics(integer, integer, keyword) :: {:ok, map} | :error
  def broadcast_action_metrics(broadcast_id, action_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps, :type])

    client.request(%{
      args: [broadcast_id: broadcast_id, action_id: action_id],
      call: {CustomerIo.Broadcasts, :broadcast_action_metrics},
      url: "/v1/broadcast/#{broadcast_id}/actions/#{action_id}/metrics",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List broadcast actions

  Returns the actions that occur as a part of a broadcast.
  """
  @spec broadcast_actions(integer, keyword) :: {:ok, map} | :error
  def broadcast_actions(broadcast_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [broadcast_id: broadcast_id],
      call: {CustomerIo.Broadcasts, :broadcast_actions},
      url: "/v1/broadcasts/#{broadcast_id}/actions",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get broadcast error descriptions

  If your broadcast produced validation errors, this endpoint can help you better understand what went wrong. Broadcast errors are generally issues in your broadcast audience and associated.


  ## Options

    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.
    * `limit`: The maximum number of results you want to retrieve per page.

  """
  @spec broadcast_errors(integer, integer, keyword) :: {:ok, map} | :error
  def broadcast_errors(broadcast_id, trigger_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:limit, :start])

    client.request(%{
      args: [broadcast_id: broadcast_id, trigger_id: trigger_id],
      call: {CustomerIo.Broadcasts, :broadcast_errors},
      url: "/v1/campaigns/#{broadcast_id}/triggers/#{trigger_id}/errors",
      method: :get,
      query: query,
      response: [{200, :map}, {401, :null}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get broadcast link metrics

  Returns metrics for link clicks within a broadcast, both in total and in `series` periods (days, weeks, etc). `series` metrics are ordered oldest to newest (i.e. the 0-index for any result is the oldest step/period).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.
    * `unique`: If true, the response contains only unique customer results, i.e. a customer who clicks a link twice is only counted once. If false, the response contains the total number of results without regard to uniqueness.

  """
  @spec broadcast_links(integer, keyword) :: {:ok, map} | :error
  def broadcast_links(broadcast_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps, :unique])

    client.request(%{
      args: [broadcast_id: broadcast_id],
      call: {CustomerIo.Broadcasts, :broadcast_links},
      url: "/v1/broadcasts/#{broadcast_id}/metrics/links",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get messages for a broadcast

  Returns information about the deliveries (instances of messages sent to individual people) sent from an API-triggered broadcast. Provide query parameters to refine the metrics you want to return.

  Use the `start_ts` and `end_ts` to find messages within a time range. If your request doesn't include `start_ts` and `end_ts` parameters, we'll return results for the 1 month period after the first trigger. If your `start_ts` and `end_ts` range is more than 12 months, we'll return 12 months of data from the most recent timestamp in your request.


  ## Options

    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.
    * `limit`: The maximum number of results you want to retrieve per page.
    * `metric`: Determines the metric(s) you want to return.
    * `state`: The state of a broadcast.
    * `type`: The type of item you want to return metrics for. When empty, the response contains metrics for all possible types.
    * `start_ts`: The beginning timestamp for your query.
    * `end_ts`: The ending timestamp for your query.

  """
  @spec broadcast_messages(integer, keyword) :: {:ok, map} | :error
  def broadcast_messages(broadcast_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:end_ts, :limit, :metric, :start, :start_ts, :state, :type])

    client.request(%{
      args: [broadcast_id: broadcast_id],
      call: {CustomerIo.Broadcasts, :broadcast_messages},
      url: "/v1/broadcasts/#{broadcast_id}/messages",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get metrics for a broadcast

  Returns a list of metrics for an individual broadcast in `steps` (days, weeks, etc). We return metrics from oldest to newest (i.e. the 0-index for any result is the oldest step/period).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.
    * `type`: The type of item you want to return metrics for. When empty, the response contains metrics for all possible types.

  """
  @spec broadcast_metrics(integer, keyword) :: {:ok, map} | :error
  def broadcast_metrics(broadcast_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps, :type])

    client.request(%{
      args: [broadcast_id: broadcast_id],
      call: {CustomerIo.Broadcasts, :broadcast_metrics},
      url: "/v1/broadcasts/#{broadcast_id}/metrics",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get the status of a broadcast

  After triggering a broadcast you can retrieve the status of that broadcast using a GET of the trigger_id resource.

  """
  @spec broadcast_status(integer, integer, keyword) :: {:ok, map} | :error
  def broadcast_status(broadcast_id, trigger_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [broadcast_id: broadcast_id, trigger_id: trigger_id],
      call: {CustomerIo.Broadcasts, :broadcast_status},
      url: "/v1/campaigns/#{broadcast_id}/triggers/#{trigger_id}",
      method: :get,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get a broadcast

  Returns metadata for an individual broadcast.
  """
  @spec get_broadcast(integer, keyword) :: {:ok, map} | :error
  def get_broadcast(broadcast_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [broadcast_id: broadcast_id],
      call: {CustomerIo.Broadcasts, :get_broadcast},
      url: "/v1/broadcasts/#{broadcast_id}",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get a broadcast action

  Returns information about a specific action within a broadcast.
  """
  @spec get_broadcast_action(integer, integer, keyword) :: {:ok, map} | :error
  def get_broadcast_action(broadcast_id, action_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [broadcast_id: broadcast_id, action_id: action_id],
      call: {CustomerIo.Broadcasts, :get_broadcast_action},
      url: "/v1/broadcasts/#{broadcast_id}/actions/#{action_id}",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get broadcast triggers

  Returns a list of the `triggers` for a broadcast.
  """
  @spec list_broadcast_triggers(integer, keyword) :: {:ok, map} | :error
  def list_broadcast_triggers(broadcast_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [broadcast_id: broadcast_id],
      call: {CustomerIo.Broadcasts, :list_broadcast_triggers},
      url: "/v1/broadcasts/#{broadcast_id}/triggers",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List broadcasts

  Returns a list of your broadcasts and associated metadata.
  """
  @spec list_broadcasts(keyword) :: {:ok, map} | :error
  def list_broadcasts(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.Broadcasts, :list_broadcasts},
      url: "/v1/broadcasts",
      method: :get,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Update a broadcast action

  Update the contents of a broadcast action, including the body of messages or HTTP requests.
  """
  @spec update_broadcast_action(
          integer,
          integer,
          CustomerIo.EmailMessage.t() | CustomerIo.Webhook.t(),
          keyword
        ) :: {:ok, map} | :error
  def update_broadcast_action(broadcast_id, action_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [broadcast_id: broadcast_id, action_id: action_id, body: body],
      call: {CustomerIo.Broadcasts, :update_broadcast_action},
      url: "/v1/broadcasts/#{broadcast_id}/actions/#{action_id}",
      body: body,
      method: :put,
      request: [
        {"application/json", {:union, [{CustomerIo.EmailMessage, :t}, {CustomerIo.Webhook, :t}]}}
      ],
      response: [{200, :map}, {400, :null}, {404, :null}, {429, :null}],
      opts: opts
    })
  end
end
