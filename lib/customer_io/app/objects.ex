defmodule CustomerIo.App.Objects do
  @moduledoc """
  Provides API endpoints related to objects
  """

  @default_client CustomerIo.App.Client

  @doc """
  List object types

  Returns a list of object types in your system. Because each object type is an incrementing ID, you may need to use this endpoint to find the ID of the object type you want to query, create, or modify.
  """
  @spec get_object_types(keyword) :: {:ok, map} | :error
  def get_object_types(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.App.Objects, :get_object_types},
      url: "/v1/object_types",
      method: :get,
      response: [{200, :map}, {401, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Find objects

  Use a set of filter conditions to find objects in your workspace. Returns a list of object IDs that you can use to look up object attributes, or to create or modify objects.

  The list is paged if you have a large number of objects. You can set the `limit` for the number of objects returned, and use the `start` to page through the results.


  ## Options

    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.
    * `limit`: The maximum number of results you want to retrieve per page.

  """
  @spec get_objects_filter(map, keyword) :: {:ok, map} | :error
  def get_objects_filter(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:limit, :start])

    client.request(%{
      args: [body: body],
      call: {CustomerIo.App.Objects, :get_objects_filter},
      url: "/v1/objects",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", :map}],
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end
end
