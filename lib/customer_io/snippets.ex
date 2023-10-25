defmodule CustomerIo.Snippets do
  @moduledoc """
  Provides API endpoints related to snippets
  """

  @default_client CustomerIo.Client

  @doc """
  Delete a snippet

  Remove a snippet. You can only remove a snippet that is not in use. If your snippet is in use, you'll receive a `400` error.
  """
  @spec delete_snippet(String.t(), keyword) :: :ok | {:error, map}
  def delete_snippet(snippet_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [snippet_name: snippet_name],
      call: {CustomerIo.Snippets, :delete_snippet},
      url: "/v1/snippets/#{snippet_name}",
      method: :delete,
      response: [{204, :null}, {400, :map}, {404, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  List snippets

  Returns a list of snippets in your workspace. Snippets are pieces of reusable content, like a common footer for your emails.
  """
  @spec list_snippets(keyword) :: {:ok, map} | :error
  def list_snippets(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.Snippets, :list_snippets},
      url: "/v1/snippets",
      method: :get,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Update snippets

  Update the `name` or `value` of a snippet.
  """
  @spec update_snippets(map, keyword) :: {:ok, map} | :error
  def update_snippets(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {CustomerIo.Snippets, :update_snippets},
      url: "/v1/snippets",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :map}, {400, :null}, {429, :null}],
      opts: opts
    })
  end
end
