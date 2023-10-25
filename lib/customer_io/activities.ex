defmodule CustomerIo.Activities do
  @moduledoc """
  Provides API endpoint related to activities
  """

  @default_client CustomerIo.Client

  @doc """
  List activities

  This endpoint returns a list of "activities" for people, similar to your workspace's Activity Logs. This endpoint is guaranteed to return activity history within the past 30 days. It _might_ return data older than 30 days in some circumstances, but activites older than 30 days are not guaranteed.

  ## Options

    * `start`: The token for the page of results you want to return. Responses contain a `next` property. Use this property as the `start` value to return the next page of results.
    * `type`: The type of activity you want to search for.
    * `name`: The name of the event or attribute you want to return.
    * `deleted`: If true, return results for deleted people.
    * `customer_id`: The `identifier` of the person you want to look up. By default, this is a person's `id`. You can use the `id_type` parameter to look up a person by `email` or `cio_id`.
      
      If you use a person's `cio_id`, you must prefix the value value with `cio_` when using it to find or reference a person (i.e. `cio_03000010` for a `cio_id` value of 03000010).
      
    * `id_type`: The type of `customer_id` you want to use to reference a person. If you don't provide this parameter, we assume that the `customer_id` in your request is a person's `id`.
    * `limit`: The maximum number of results you want to retrieve per page.

  """
  @spec list_activities(keyword) :: {:ok, map} | :error
  def list_activities(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:customer_id, :deleted, :id_type, :limit, :name, :start, :type])

    client.request(%{
      args: [],
      call: {CustomerIo.Activities, :list_activities},
      url: "/v1/activities",
      method: :get,
      query: query,
      response: [{200, :map}, {429, :null}],
      opts: opts
    })
  end
end
