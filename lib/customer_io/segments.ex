defmodule CustomerIo.Segments do
  @moduledoc """
  Provides API endpoints related to segments
  """

  @default_client CustomerIo.Client

  @doc """
  Create a manual segment

  Create a manual segment with a name and a description. This request creates an empty segment.
  """
  @spec create_man_segment(map, keyword) :: {:ok, map} | :error
  def create_man_segment(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {CustomerIo.Segments, :create_man_segment},
      url: "/v1/segments",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, {400, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Delete a segment

  Delete a manual segment.
  """
  @spec delete_man_segment(integer, keyword) :: :ok | :error
  def delete_man_segment(segment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [segment_id: segment_id],
      call: {CustomerIo.Segments, :delete_man_segment},
      url: "/v1/segments/#{segment_id}",
      method: :delete,
      response: [{204, :null}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get a segment

  Return information about a segment.
  """
  @spec get_segment(integer, keyword) :: {:ok, map} | :error
  def get_segment(segment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [segment_id: segment_id],
      call: {CustomerIo.Segments, :get_segment},
      url: "/v1/segments/#{segment_id}",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get a segment customer count

  Returns the membership count for a segment.
  """
  @spec get_segment_count(integer, keyword) :: {:ok, map} | :error
  def get_segment_count(segment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [segment_id: segment_id],
      call: {CustomerIo.Segments, :get_segment_count},
      url: "/v1/segments/#{segment_id}/customer_count",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Get a segment's dependencies

  Use this endpoint to find out which campaigns and newsletters use a segment.
  """
  @spec get_segment_dependencies(integer, keyword) :: {:ok, map} | :error
  def get_segment_dependencies(segment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [segment_id: segment_id],
      call: {CustomerIo.Segments, :get_segment_dependencies},
      url: "/v1/segments/#{segment_id}/used_by",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List customers in a segment

  Returns customers in a segment. This endpoint returns an array of `identifiers`; each object in the array represents a person and contains the identifier values allowed in your workspace. In general, we recommend that you use `identifiers` rather than `ids` to find people, because it provides more information.  

  **If your workspace does not use email as a unique identifier** for people, `identifiers` does not contain `email` values. Go to your [Workspace Settings](/docs/workspaces/#migrate-workspace) to find out which identifiers your workspace supports.

  The `ids` array only lists ID values for people in a segment; if your workspace uses both `email` and `id` as identifiers, it's possible that a member of your segment does not have an `id` value, resulting in an empty string in the `ids` array.


  ## Options

    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.
    * `limit`: The maximum number of results you want to retrieve per page.

  """
  @spec get_segment_membership(integer, keyword) ::
          {:ok, CustomerIo.EmailOrId.t() | CustomerIo.IdOnly.t()} | :error
  def get_segment_membership(segment_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:limit, :start])

    client.request(%{
      args: [segment_id: segment_id],
      call: {CustomerIo.Segments, :get_segment_membership},
      url: "/v1/segments/#{segment_id}/membership",
      method: :get,
      query: query,
      response: [
        {200, {:union, [{CustomerIo.EmailOrId, :t}, {CustomerIo.IdOnly, :t}]}},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  List segments

  Retrieve a list of all of your segments.
  """
  @spec list_segments(keyword) :: {:ok, map} | :error
  def list_segments(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.Segments, :list_segments},
      url: "/v1/segments",
      method: :get,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end
end
