defmodule CustomerIo.Campaigns do
  @moduledoc """
  Provides API endpoints related to campaigns
  """

  @default_client CustomerIo.Client

  @doc """
  Get link metrics for an action

  Returns link click metrics for an individual action. Unless you specify otherwise, the response contains data for the maximum period by days (45 days).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.
    * `type`: The type of item you want to return metrics for. When empty, the response contains metrics for all possible types.

  """
  @spec campaign_action_links(integer, integer, keyword) :: {:ok, map} | :error
  def campaign_action_links(campaign_id, action_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps, :type])

    client.request(%{
      args: [campaign_id: campaign_id, action_id: action_id],
      call: {CustomerIo.Campaigns, :campaign_action_links},
      url: "/v1/campaigns/#{campaign_id}/actions/#{action_id}/metrics/links",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get campaign action metrics

  Returns a list of metrics for an individual action both in total and in `steps` (days, weeks, etc) over a period of time. Stepped `series` metrics return from oldest to newest (i.e. the 0-index for any result is the oldest step/period).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.
    * `type`: The type of item you want to return metrics for. When empty, the response contains metrics for all possible types.

  """
  @spec campaign_action_metrics(integer, integer, keyword) :: {:ok, map} | :error
  def campaign_action_metrics(campaign_id, action_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps, :type])

    client.request(%{
      args: [campaign_id: campaign_id, action_id: action_id],
      call: {CustomerIo.Campaigns, :campaign_action_metrics},
      url: "/v1/campaigns/#{campaign_id}/actions/#{action_id}/metrics",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get campaign journey metrics

  Returns a list of Journey Metrics for your campaign. These metrics show how many people triggered your campaign, were messaged, etc for the time period and "resolution" you set. You must provide the `start`, `end`, and `resolution` parameters or your request will return `400`.

  Metrics in the response are arrays, and each index in the array corresponds to the `resolution` in your request. If you request metrics in `days`, the first result in each metric array is the first day of results and each successive increment represents another day. 

  Each increment represents the number of journeys that started within a time period and eventually achieved a particular metric. For example, array index 0 for the `converted` metric represents the number of journeys that started on the first day/month of results that achieved a conversion.


  ## Options

    * `start`: The unix timestamp for the beginning of your journey metrics report.
    * `end`: The unix timestamp for the end of your journey metrics report.
    * `resolution`: Determines increment for journey metrics—hourly, daily, weekly, or monthly.

  """
  @spec campaign_journey_metrics(integer, keyword) :: {:ok, map} | :error
  def campaign_journey_metrics(campaign_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:end, :resolution, :start])

    client.request(%{
      args: [campaign_id: campaign_id],
      call: {CustomerIo.Campaigns, :campaign_journey_metrics},
      url: "/v1/campaigns/#{campaign_id}/journey_metrics",
      method: :get,
      query: query,
      response: [{200, :map}, {400, :null}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get campaign link metrics

  Returns metrics for link clicks within a campaign, both in total and in `series` periods (days, weeks, etc). `series` metrics are ordered oldest to newest (i.e. the 0-index for any result is the oldest step/period).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.
    * `unique`: If true, the response contains only unique customer results, i.e. a customer who clicks a link twice is only counted once. If false, the response contains the total number of results without regard to uniqueness.

  """
  @spec campaign_link_metrics(integer, keyword) :: {:ok, map} | :error
  def campaign_link_metrics(campaign_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps, :unique])

    client.request(%{
      args: [campaign_id: campaign_id],
      call: {CustomerIo.Campaigns, :campaign_link_metrics},
      url: "/v1/campaigns/#{campaign_id}/metrics/links",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get campaign metrics

  Returns a list of metrics for an individual campaign in `steps` (days, weeks, etc). We return metrics from oldest to newest (i.e. the 0-index for any result is the oldest step/period).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.
    * `type`: The type of item you want to return metrics for. When empty, the response contains metrics for all possible types.

  """
  @spec campaign_metrics(integer, keyword) :: {:ok, map} | :error
  def campaign_metrics(campaign_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps, :type])

    client.request(%{
      args: [campaign_id: campaign_id],
      call: {CustomerIo.Campaigns, :campaign_metrics},
      url: "/v1/campaigns/#{campaign_id}/metrics",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get a campaign action

  Returns information about a specific action in a campaign.

  ## Options

    * `language`: A [language tag](/docs/journeys/unsubscribes/#currently-supported-languages) of the language variation you want to update. If none is provided or the language variation doesn't exist, the default/original action will be updated.

  """
  @spec get_campaign_action(integer, integer, keyword) :: {:ok, map} | :error
  def get_campaign_action(campaign_id, action_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:language])

    client.request(%{
      args: [campaign_id: campaign_id, action_id: action_id],
      call: {CustomerIo.Campaigns, :get_campaign_action},
      url: "/v1/campaigns/#{campaign_id}/actions/#{action_id}/language/:language",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get campaign message metadata

  Returns information about the deliveries (instances of messages sent to individual people) sent from a campaign. Provide query parameters to refine the metrics you want to return.
  Use the `start_ts` and `end_ts` to find messages within a time range. If your request doesn't include `start_ts` and `end_ts` parameters, we'll return the most recent 6 months of messages. If your `start_ts` and `end_ts` range is more than 12 months, we'll return 12 months of data from the most recent timestamp in your request.

  ## Options

    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.
    * `limit`: The maximum number of results you want to retrieve per page.
    * `type`: The type of item you want to return metrics for. When empty, the response contains metrics for all possible types.
    * `metric`: Determines the metric(s) you want to return.
    * `drafts`: If true, your request returns drafts rather than active/sent messages.
    * `start_ts`: The beginning timestamp for your query.
    * `end_ts`: The ending timestamp for your query.

  """
  @spec get_campaign_messages(integer, keyword) :: {:ok, map} | :error
  def get_campaign_messages(campaign_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:drafts, :end_ts, :limit, :metric, :start, :start_ts, :type])

    client.request(%{
      args: [campaign_id: campaign_id],
      call: {CustomerIo.Campaigns, :get_campaign_messages},
      url: "/v1/campaigns/#{campaign_id}/messages",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get a campaign

  Returns metadata for an individual campaign.
  """
  @spec get_campaigns(integer, keyword) :: {:ok, map} | :error
  def get_campaigns(campaign_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [campaign_id: campaign_id],
      call: {CustomerIo.Campaigns, :get_campaigns},
      url: "/v1/campaigns/#{campaign_id}",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List campaign actions

  Returns the operations in a campaign workflow. Each object in the response represents an action or 'tile' in the campaign builder.

  This endpoint returns up to 10 `actions` at a time. If there is another page of results, the response will include a `next` string. Pass this string as the `start` parameter to get the next page of results.


  ## Options

    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.

  """
  @spec list_campaign_actions(integer, keyword) :: {:ok, map} | :error
  def list_campaign_actions(campaign_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:start])

    client.request(%{
      args: [campaign_id: campaign_id],
      call: {CustomerIo.Campaigns, :list_campaign_actions},
      url: "/v1/campaigns/#{campaign_id}/actions",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List campaigns

  Returns a list of your campaigns and associated metadata.
  """
  @spec list_campaigns(keyword) :: {:ok, map} | :error
  def list_campaigns(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.Campaigns, :list_campaigns},
      url: "/v1/campaigns",
      method: :get,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Update a campaign action

  Update the contents of a campaign action, including the body of messages and HTTP requests.

  ## Options

    * `language`: A [language tag](/docs/journeys/unsubscribes/#currently-supported-languages) of the language variation you want to update. If none is provided or the language variation doesn't exist, the default/original action will be updated.

  """
  @spec update_campaign_action(
          integer,
          integer,
          CustomerIo.EmailMessage.t() | CustomerIo.Webhook.t(),
          keyword
        ) :: {:ok, CustomerIo.EmailMessage.t() | CustomerIo.Webhook.t()} | :error
  def update_campaign_action(campaign_id, action_id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:language])

    client.request(%{
      args: [campaign_id: campaign_id, action_id: action_id, body: body],
      call: {CustomerIo.Campaigns, :update_campaign_action},
      url: "/v1/campaigns/#{campaign_id}/actions/#{action_id}/language/:language",
      body: body,
      method: :put,
      query: query,
      request: [
        {"application/json", {:union, [{CustomerIo.EmailMessage, :t}, {CustomerIo.Webhook, :t}]}}
      ],
      response: [
        {200, {:union, [{CustomerIo.EmailMessage, :t}, {CustomerIo.Webhook, :t}]}},
        {400, :null},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end
end
