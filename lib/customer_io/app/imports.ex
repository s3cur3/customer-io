defmodule CustomerIo.App.Imports do
  @moduledoc """
  Provides API endpoints related to imports
  """

  @default_client CustomerIo.App.Client

  @doc """
  Retrieve a bulk import

  This endpoint returns information about an "import"—a CSV file containing a group of people or events you uploaded to using `v1/imports` endpoint. You can use this endpoint to check to status of imports, or find out how many rows you successfully imported from a CSV file.
  """
  @spec get_import(integer, keyword) :: {:ok, map} | :error
  def get_import(import_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [import_id: import_id],
      call: {CustomerIo.App.Imports, :get_import},
      url: "/v1/imports/#{import_id}",
      method: :get,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Import people/events in bulk

  This endpoint lets you upload a CSV file containing people or events, providing a handy way to add and update people or events in bulk. Uploading people is like performing an [`identify` call](#operation/identify) for each row in your CSV; Uploading events is like performing a [`track` call](#operation/track).

  You'll need to provide us the public URL of your CSV as a part of this operation. We recommend that you host your CSVs from short-lived URLs. Ideally, your URLs will expire 2 hours after you initiate an import—so that your customers' information doesn't remain publicly available after you've uploaded it to us.

  Your CSV must [conform to the rules shared here](/docs/uploading-people/#csv-requirements). Your CSV must contain a column using the `identifier` value in the request. For example, if your `identifier` is `id`, your CSV must have a column titled `id`.

  """
  @spec import(map, keyword) :: {:ok, map} | :error
  def import body, opts \\ [] do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {CustomerIo.App.Imports, :import},
      url: "/v1/imports",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end
end
