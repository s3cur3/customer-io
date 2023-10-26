defmodule CustomerIo.Track.TrackRegion do
  @moduledoc """
  Provides API endpoint related to track region
  """

  @default_client CustomerIo.Track.Client

  @doc """
  Find your account region

  This endpoint returns the appropriate region and URL for your Track API credentials. Use it to determine the URLs you should use to successfully complete other requests.

  You can perform this operation against either of the track API regional URLs; it returns your region in either case. 

  This endpoint also returns an `environment_id`, which represents the workspace the credentials are valid for. 

  """
  @spec get_region(keyword) :: {:ok, map} | :error
  def get_region(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {CustomerIo.Track.TrackRegion, :get_region},
      url: "/api/v1/accounts/region",
      method: :get,
      response: [{200, :map}, {400, :null}],
      opts: opts
    })
  end
end
