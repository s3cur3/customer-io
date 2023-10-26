defmodule CustomerIo.App.Newsletters do
  @moduledoc """
  Provides API endpoints related to newsletters
  """

  @default_client CustomerIo.App.Client

  @doc """
  Get newsletter link metrics

  Returns metrics for link clicks within a newsletter, both in total and in `series` periods (days, weeks, etc). `series` metrics are ordered oldest to newest (i.e. the 0-index for any result is the oldest step/period).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.
    * `unique`: If true, the response contains only unique customer results, i.e. a customer who clicks a link twice is only counted once. If false, the response contains the total number of results without regard to uniqueness.

  """
  @spec get_newsletter_links(integer, keyword) :: {:ok, map} | :error
  def get_newsletter_links(newsletter_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps, :unique])

    client.request(%{
      args: [newsletter_id: newsletter_id],
      call: {CustomerIo.App.Newsletters, :get_newsletter_links},
      url: "/v1/newsletters/#{newsletter_id}/metrics/links",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get newsletter metrics

  Returns a list of metrics for an individual newsletter in `steps` (days, weeks, etc). We return metrics from oldest to newest (i.e. the 0-index for any result is the oldest step/period).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.
    * `type`: The type of item you want to return metrics for. When empty, the response contains metrics for all possible types.

  """
  @spec get_newsletter_metrics(integer, keyword) :: {:ok, map} | :error
  def get_newsletter_metrics(newsletter_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps, :type])

    client.request(%{
      args: [newsletter_id: newsletter_id],
      call: {CustomerIo.App.Newsletters, :get_newsletter_metrics},
      url: "/v1/newsletters/#{newsletter_id}/metrics",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get newsletter message metadata

  Returns information about the deliveries (instances of messages sent to individual people) sent from a newsletter. Provide query parameters to refine the metrics you want to return.
  Use the `start_ts` and `end_ts` to find messages within a time range. If your request doesn't include `start_ts` and `end_ts` parameters, we'll return up to 6 months of results beginning with the first delivery generated from the newsletter. If your `start_ts` and `end_ts` range is more than 12 months, we'll return 12 months of data from the most recent timestamp in your request.

  ## Options

    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.
    * `limit`: The maximum number of results you want to retrieve per page.
    * `metric`: Determines the metric(s) you want to return.
    * `start_ts`: The beginning timestamp for your query.
    * `end_ts`: The ending timestamp for your query.

  """
  @spec get_newsletter_msg_meta(integer, keyword) :: {:ok, map} | :error
  def get_newsletter_msg_meta(newsletter_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:end_ts, :limit, :metric, :start, :start_ts])

    client.request(%{
      args: [newsletter_id: newsletter_id],
      call: {CustomerIo.App.Newsletters, :get_newsletter_msg_meta},
      url: "/v1/newsletters/#{newsletter_id}/messages",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get a newsletter variant

  Returns information about a specific variant of a newsletter, where a variant is either a language in a multi-language newsletter or a part of an A/B test.
  """
  @spec get_newsletter_variant(integer, integer, keyword) :: {:ok, map} | :error
  def get_newsletter_variant(newsletter_id, content_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [newsletter_id: newsletter_id, content_id: content_id],
      call: {CustomerIo.App.Newsletters, :get_newsletter_variant},
      url: "/v1/newsletters/#{newsletter_id}/contents/#{content_id}",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get a newsletter

  Returns metadata for an individual newsletter.
  """
  @spec get_newsletters(integer, keyword) :: {:ok, map} | :error
  def get_newsletters(newsletter_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [newsletter_id: newsletter_id],
      call: {CustomerIo.App.Newsletters, :get_newsletters},
      url: "/v1/newsletters/#{newsletter_id}",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get newsletter variant link metrics

  Returns link click metrics for an individual newsletter variant—an individual language in a multi-language newsletter or a message in an A/B test. Unless you specify otherwise, the response contains data for the maximum period by days (45 days).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.
    * `type`: The type of item you want to return metrics for. When empty, the response contains metrics for all possible types.

  """
  @spec get_variant_links(integer, integer, keyword) :: {:ok, map} | :error
  def get_variant_links(newsletter_id, content_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps, :type])

    client.request(%{
      args: [newsletter_id: newsletter_id, content_id: content_id],
      call: {CustomerIo.App.Newsletters, :get_variant_links},
      url: "/v1/newsletters/#{newsletter_id}/contents/#{content_id}/metrics/links",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get metrics for a variant

  Returns a metrics for an individual newsletter variant—either an individual language in a multi-language newsletter or a message in an A/B test. This endpoint returns metrics both in total and in `steps` (days, weeks, etc) over a `period` of time. Stepped `series` metrics are arranged from oldest to newest (i.e. the 0-index for any result is the oldest period/step).

  ## Options

    * `period`: The unit of time for your report.
    * `steps`: The number of periods you want to return. Defaults to the maximum available, or `12` if the period is in `months`. Maximums are 24 hours, 45 days, 12 weeks, or 120 months.
    * `type`: The type of item you want to return metrics for. When empty, the response contains metrics for all possible types.

  """
  @spec get_variant_metrics(integer, integer, keyword) :: {:ok, map} | :error
  def get_variant_metrics(newsletter_id, content_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:period, :steps, :type])

    client.request(%{
      args: [newsletter_id: newsletter_id, content_id: content_id],
      call: {CustomerIo.App.Newsletters, :get_variant_metrics},
      url: "/v1/newsletters/#{newsletter_id}/contents/#{content_id}/metrics",
      method: :get,
      query: query,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List newsletter variants

  Returns the content variants of a newsletter—these are either different languages in a multi-language newsletter or A/B tests.
  """
  @spec list_newsletter_variants(integer, keyword) :: {:ok, map} | :error
  def list_newsletter_variants(newsletter_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [newsletter_id: newsletter_id],
      call: {CustomerIo.App.Newsletters, :list_newsletter_variants},
      url: "/v1/newsletters/#{newsletter_id}/contents",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List newsletters

  Returns a list of your newsletters and associated metadata.
  """
  @spec list_newsletters(keyword) :: {:ok, map} | :error
  def list_newsletters(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.App.Newsletters, :list_newsletters},
      url: "/v1/newsletters",
      method: :get,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Update a newsletter variant

  Update the contents of a newsletter variant (a specific language of your message or a part of an A/B test), including the body of a newsletter.
  """
  @spec update_newsletter_variant(integer, integer, map, keyword) :: {:ok, map} | :error
  def update_newsletter_variant(newsletter_id, content_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [newsletter_id: newsletter_id, content_id: content_id, body: body],
      call: {CustomerIo.App.Newsletters, :update_newsletter_variant},
      url: "/v1/newsletters/#{newsletter_id}/contents/#{content_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :map}, {400, :null}, {404, :null}, {429, :null}],
      opts: opts
    })
  end
end
