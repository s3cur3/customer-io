defmodule CustomerIo.Collections do
  @moduledoc """
  Provides API endpoints related to collections
  """

  @default_client CustomerIo.Client

  @doc """
  Create a collection

  Create a new collection and provide the `data` that you'll access from the collection or the `url` that you'll download CSV or JSON data from.

  **Note**: A collection cannot be more than 10 MB in size. No individual row in the collection can be more than 10 KB.

  """
  @spec add_collection(CustomerIo.DataByUrl.t() | CustomerIo.LocalData.t(), keyword) ::
          {:ok, map} | :error
  def add_collection(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {CustomerIo.Collections, :add_collection},
      url: "/v1/collections",
      body: body,
      method: :post,
      request: [
        {"application/json", {:union, [{CustomerIo.DataByUrl, :t}, {CustomerIo.LocalData, :t}]}}
      ],
      response: [{200, :map}, {400, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Delete a collection

  Remove a collection and associated contents. Before you delete a collection, make sure that you aren't referencing it in active campaign messages or broadcasts; references to a deleted collection will appear empty and may prevent your messages from making sense to your audience.
  """
  @spec delete_collection(integer, keyword) :: :ok | :error
  def delete_collection(collection_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [collection_id: collection_id],
      call: {CustomerIo.Collections, :delete_collection},
      url: "/v1/collections/#{collection_id}",
      method: :delete,
      response: [{204, :null}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Lookup a collection

  Retrieves details about a collection, including the `schema` and `name`. This request does not include the `content` of the collection (the values associated with keys in the schema).
  """
  @spec get_collection(integer, keyword) :: {:ok, map} | :error
  def get_collection(collection_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [collection_id: collection_id],
      call: {CustomerIo.Collections, :get_collection},
      url: "/v1/collections/#{collection_id}",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Lookup collection contents

  Retrieve the contents of a collection (the `data` from when you created or updated a collection). Each `row` in the collection is represented as a JSON blob in the response.
  """
  @spec get_collection_contents(integer, keyword) :: {:ok, map} | :error
  def get_collection_contents(collection_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [collection_id: collection_id],
      call: {CustomerIo.Collections, :get_collection_contents},
      url: "/v1/collections/#{collection_id}/content",
      method: :get,
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List your collections

  Returns a list of all of your collections, including the `name` and `schema` for each collection.
  """
  @spec get_collections(keyword) :: {:ok, map} | :error
  def get_collections(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.Collections, :get_collections},
      url: "/v1/collections",
      method: :get,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Update a collection

  Update the `name` or replace the contents of a collection. Updating the `data` or `url` for your collection fully replaces the contents of the collection.

  **Note**: 
  * If you reference your collection by name in active campaign messages, changing the name of the collection will cause references to the previous name to return an empty data set.
  * A collection cannot be more than 10 MB in size. No individual row in the collection can be more than 10 KB.

  """
  @spec update_collection(integer, CustomerIo.DataByUrl.t() | CustomerIo.LocalData.t(), keyword) ::
          {:ok, map} | :error
  def update_collection(collection_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [collection_id: collection_id, body: body],
      call: {CustomerIo.Collections, :update_collection},
      url: "/v1/collections/#{collection_id}",
      body: body,
      method: :put,
      request: [
        {"application/json", {:union, [{CustomerIo.DataByUrl, :t}, {CustomerIo.LocalData, :t}]}}
      ],
      response: [{200, :map}, {400, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Update the contents of a collection

  Replace the contents of a collection (the `data` from when you created or updated a collection). The request is a free-form object containing the keys you want to reference from the collection and the corresponding values. This request replaces the current contents of the collection entirely.

  If you don't want to update the contents directly—you want to change the `name` or data `url` for your collection, use the [update a collection](#operation/updateCollection) endpoint.

  **Note**: A collection cannot be more than 10 MB in size. No individual row in the collection can be more than 10 KB.

  """
  @spec update_collection_contents(integer, map, keyword) :: {:ok, map} | :error
  def update_collection_contents(collection_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [collection_id: collection_id, body: body],
      call: {CustomerIo.Collections, :update_collection_contents},
      url: "/v1/collections/#{collection_id}/content",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end
end
