defmodule CustomerIo.Track.TrackSegments do
  @moduledoc """
  Provides API endpoints related to track segments
  """

  @default_client CustomerIo.Track.Client

  @doc """
  Add people to a manual segment

  Add people to a manual segment by ID. You are limited to 1000 customer IDs per request.

  This endpoint requires people to have `id` attributes. If your workspace does not use `id` as an identifier, or you have not assigned people `id` values, you cannot add people to manual segments using the API. Our user interface does not have this limitation. You can add people to manual segments through the UI when you upload a CSV of people or as a part of a campaign. If you pass an `id` that does not belong to anybody in your workspace, we'll ignore it.

  This endpoint lets you add people to manual segments, but a segment must exist before you can add people to it. You can create and find manual segments using the [App API](/docs/api/#operation/createManSegment).

  **NOTE**: You cannot add people to data-driven segments using the API. See [our documentation on segments](/docs/segments) for more information about segments.


  ## Options

    * `id_type`: The type of `ids` you want to use. All of the values in the `ids` array must be of this type. If you don't provide this parameter, we assume that the `ids` array contains `id` values.

  """
  @spec add_to_segment(integer, map, keyword) :: :ok | {:error, String.t()}
  def add_to_segment(segment_id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:id_type])

    client.request(%{
      args: [segment_id: segment_id, body: body],
      call: {CustomerIo.Track.TrackSegments, :add_to_segment},
      url: "/api/v1/segments/#{segment_id}/add_customers",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", :map}],
      response: [{200, :null}, {401, :null}, {404, {:string, :generic}}],
      opts: opts
    })
  end

  @doc """
  Remove people from a manual segment

  You can remove users from a manual segment by ID. You are limited to 1000 customer IDs per request.

  This endpoint requires people to have `id` attributes. If your workspace does not use `id` as an identifier, or you have not assigned people `id` values, you cannot remove people from manual segments using the API. Our user interface does not have this limitation. You can remove people from manual segments through the UI as a part of a campaign workflow.

  **NOTE**: You cannot remove people from data-driven segments using the API. See [our documentation on segments](/docs/segments) for more information about segments.


  ## Options

    * `id_type`: The type of `ids` you want to use. All of the values in the `ids` array must be of this type. If you don't provide this parameter, we assume that the `ids` array contains `id` values.

  """
  @spec remove_from_segment(integer, map, keyword) :: :ok | {:error, String.t()}
  def remove_from_segment(segment_id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:id_type])

    client.request(%{
      args: [segment_id: segment_id, body: body],
      call: {CustomerIo.Track.TrackSegments, :remove_from_segment},
      url: "/api/v1/segments/#{segment_id}/remove_customers",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", :map}],
      response: [{200, :null}, {401, :null}, {404, {:string, :generic}}],
      opts: opts
    })
  end
end
