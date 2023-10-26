defmodule CustomerIo.Track.TrackV2 do
  @moduledoc """
  Provides API endpoints related to track v2
  """

  @default_client CustomerIo.Track.Client

  @doc """
  Send multiple requests

  This endpoint lets you batch requests for different people and objects in a single request. Each object in your array represents an individual "entity" operation—it represents a change for a person, an object, or a delivery. 

  You can mix types in this request; you are not limited to a batch containing only objects or only people. An "object" is a non-person entity that you want to associate with one or more people—like a company, an educational course that people enroll in, etc.

  Your request must be smaller than 500kb.

  """
  @spec batch(map, keyword) :: {:ok, map} | {:error, map}
  def batch(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {CustomerIo.Track.TrackV2, :batch},
      url: "/api/v2/batch",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :null}, {207, :map}, {400, :map}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Make a single request

  This endpoint lets you create, update, or delete a single person or object—including managing relationships between objects and people. 

  An "object" is any kind of non-person entity that you want to associate with one or more people—like a company, an educational course that people signed up for, a product, etc. 

  Your request must be smaller than 32kb. 

  """
  @spec entity(map | CustomerIo.Track.Delivery.t(), keyword) :: :ok | {:error, map}
  def entity(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {CustomerIo.Track.TrackV2, :entity},
      url: "/api/v2/entity",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, {CustomerIo.Track.Delivery, :t}]}}],
      response: [{200, :null}, {400, :map}, {401, :null}],
      opts: opts
    })
  end
end
